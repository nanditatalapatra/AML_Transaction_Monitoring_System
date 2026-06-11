-- =============================================
-- AML TRANSACTION MONITORING
-- FILE: PAYSIM MAPPING SCRIPT
-- Maps PaySim staging data → AML Schema
-- =============================================

-- =============================================
-- STEP 1: INSERT CUSTOMERS
-- PaySim has no customer data so we create
-- a generic customer for each unique account
-- =============================================

INSERT INTO customers (
    full_name,
    country_of_origin,
    nationality,
    kyc_status,
    risk_rating,
    pep_flag,
    created_at
)
SELECT DISTINCT
    'Customer_' || nameOrig          AS full_name,
    'USA'                            AS country_of_origin,
    'American'                       AS nationality,
    'verified'                       AS kyc_status,
    CASE
        WHEN nameOrig IN (
            SELECT DISTINCT nameOrig
            FROM paysim_staging
            WHERE isfraud = 1
        ) THEN 'high'
        ELSE 'low'
    END                              AS risk_rating,
    FALSE                            AS pep_flag,
    NOW()                            AS created_at
FROM paysim_staging
WHERE nameOrig LIKE 'C%'    -- C = customer accounts (M = merchant)
ON CONFLICT DO NOTHING;

select count(*) from customers;


-- =============================================
-- STEP 2: INSERT ACCOUNTS
-- One account per unique nameOrig
-- =============================================

INSERT INTO accounts (
    customer_id,
    account_type,
    account_status,
    open_date,
    currency,
    branch_code,
    branch_city,
    current_balance
)
SELECT DISTINCT ON (p.nameOrig)
    c.customer_id                    AS customer_id,
    'checking'                       AS account_type,
    'active'                         AS account_status,
    CURRENT_DATE - INTERVAL '1 year' AS open_date,
    'USD'                            AS currency,
    'BR001'                          AS branch_code,
    'New York'                       AS branch_city,
    p.newbalanceorig                 AS current_balance
FROM paysim_staging p
JOIN customers c
    ON c.full_name = 'Customer_' || p.nameOrig
WHERE p.nameOrig LIKE 'C%'
ON CONFLICT DO NOTHING;


-- =============================================
-- STEP 3: INSERT TRANSACTIONS
-- Map PaySim transactions → AML transactions
-- =============================================

INSERT INTO transactions (
    account_id,
    txn_date,
    txn_type,
    amount,
    currency,
    counterparty_name,
    counterparty_account,
    counterparty_bank,
    counterparty_country,
    channel,
    purpose,
    status,
    reference_no
)
SELECT
    a.account_id                     AS account_id,

    -- Convert step (hour) to actual timestamp
    -- Step 1 = hour 1 of simulation starting Jan 1 2024
    TIMESTAMP '2024-01-01 00:00:00'
        + (p.step * INTERVAL '1 hour') AS txn_date,

    -- Map PaySim type to AML txn_type
    CASE p.type
        WHEN 'PAYMENT'  THEN 'deposit'
        WHEN 'CASH_IN'  THEN 'deposit'
        WHEN 'CASH_OUT' THEN 'withdrawal'
        WHEN 'DEBIT'    THEN 'withdrawal'
        WHEN 'TRANSFER' THEN 'transfer'
        ELSE 'transfer'
    END                              AS txn_type,

    p.amount                         AS amount,
    'USD'                            AS currency,
    'Counterparty_' || p.nameDest    AS counterparty_name,
    p.nameDest                       AS counterparty_account,
    'External Bank'                  AS counterparty_bank,

    -- Assign country based on fraud flag
    CASE
        WHEN p.isfraud = 1 THEN 'Panama'
        ELSE 'USA'
    END                              AS counterparty_country,

    -- Map channel based on transaction type
    CASE p.type
        WHEN 'PAYMENT'  THEN 'online'
        WHEN 'CASH_IN'  THEN 'branch'
        WHEN 'CASH_OUT' THEN 'ATM'
        WHEN 'DEBIT'    THEN 'online'
        WHEN 'TRANSFER' THEN 'wire'
        ELSE 'online'
    END                              AS channel,

    p.type                           AS purpose,

    -- Mark fraudulent as reversed, clean as completed
    CASE
        WHEN p.isfraud = 1 THEN 'completed'
        ELSE 'completed'
    END                              AS status,

    'PAY-' || p.nameOrig || '-' || p.step AS reference_no

FROM paysim_staging p
JOIN accounts a
    ON a.account_id = (
        SELECT a2.account_id
        FROM accounts a2
        JOIN customers c2
            ON a2.customer_id = c2.customer_id
        WHERE c2.full_name = 'Customer_' || p.nameOrig
        LIMIT 1
    )
WHERE p.nameOrig LIKE 'C%';


-- =============================================
-- STEP 4: INSERT ALERTS
-- Flag all fraudulent transactions as alerts
-- =============================================

INSERT INTO alerts (
    txn_id,
    account_id,
    customer_id,
    alert_type,
    alert_category,
    alert_date,
    risk_score,
    status,
    description
)
SELECT
    t.txn_id,
    t.account_id,
    a.customer_id,
    'Fraud detected by PaySim model'     AS alert_type,
    'pattern'                            AS alert_category,
    NOW()                                AS alert_date,
    95                                   AS risk_score,
    'open'                               AS status,
    'Transaction flagged as fraudulent in PaySim dataset'  AS description
FROM transactions t
JOIN accounts a     ON t.account_id = a.account_id
JOIN paysim_staging p
    ON t.reference_no = 'PAY-' || p.nameOrig || '-' || p.step
WHERE p.isfraud = 1;


-- =============================================
-- STEP 5: VERIFY ALL COUNTS
-- =============================================

SELECT 'customers'    AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'accounts'     AS table_name, COUNT(*) AS total_records FROM accounts
UNION ALL
SELECT 'transactions' AS table_name, COUNT(*) AS total_records FROM transactions
UNION ALL
SELECT 'alerts'       AS table_name, COUNT(*) AS total_records FROM alerts;
