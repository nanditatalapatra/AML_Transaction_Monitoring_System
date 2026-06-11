-- =============================================
-- CATEGORY 1: STRUCTURING / SMURFING
-- =============================================

-- Query 1.1: Single-day structuring


SELECT 
a.account_id, 
c.full_name, 
DATE(t.txn_date) AS txn_day, 
COUNT(t.txn_id)    AS txn_count,
SUM(t.amount)    AS total_amount
FROM transactions t
JOIN accounts a  ON a.account_id=t.account_id
JOIN customers c ON a.customer_id =c.customer_id 
WHERE t.amount BETWEEN 5000 AND 9999
AND t.txn_type IN ('deposit','withdrawal')
GROUP BY a.account_id,c.full_name,DATE(t.txn_date)
HAVING COUNT(t.txn_id) >= 3
ORDER BY total_amount DESC
;


-- INSERT INTO ALERTS for Single-day structuring

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
    MIN(t.txn_id)                   AS txn_id,
    a.account_id,
    c.customer_id,
    'Single-day structuring'        AS alert_type,
    'structuring'                   AS alert_category,
    NOW()                           AS alert_date,
    85                              AS risk_score,
    'open'                          AS status,
    'Account made 3+ transactions between $5K-$9,999 on ' ||
    DATE(t.txn_date)::TEXT ||
    ' Total amount: $' ||
    SUM(t.amount)::TEXT             AS description
FROM transactions t
JOIN accounts a     ON t.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE t.amount      BETWEEN 5000 AND 9999
AND   t.txn_type    IN ('deposit', 'withdrawal')
GROUP BY a.account_id, c.full_name, 
         c.customer_id, DATE(t.txn_date)
HAVING COUNT(t.txn_id) >= 3;


-- Query 1.2: Same account, 3+ transactions between $5K–$9,999 spread over 3–5 days
--=================================================================================

SELECT
a.account_id,
c.customer_id,
c.full_name,
count(*)            AS txn_count,
SUM(t.amount)       AS total_amount,
MIN(DATE(t.txn_date))        AS min_txn_date,
MAX(DATE(T.txn_date))       AS max_txn_date,
MAX(DATE(T.txn_date)) - MIN(DATE(t.txn_date))       AS days_spread
FROM transactions t
JOIN accounts a ON a.account_id=t.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.amount BETWEEN 5000 AND 9999
GROUP BY a.account_id,c.customer_id,c.full_name
HAVING COUNT(*) >=3 AND MAX(DATE(T.txn_date)) - MIN(DATE(t.txn_date)) BETWEEN 3 AND 5
;

-- INSERT INTO ALERTS for Multi -day structuring

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
    MIN(t.txn_id)                   AS txn_id,
    a.account_id,
    c.customer_id,
    'Multi-day structuring'        AS alert_type,
    'structuring'                   AS alert_category,
    NOW()                           AS alert_date,
    (
        CASE
            WHEN COUNT(*) BETWEEN 3 AND 5 THEN 70
            WHEN COUNT(*) BETWEEN 6 AND 10 THEN 80
            ELSE 85
        END
        +
        CASE
            WHEN c.risk_rating = 'high' THEN 10
            WHEN c.risk_rating = 'medium' THEN 5
            ELSE 0
        END
        +
        CASE WHEN c.pep_flag = TRUE THEN 10 ELSE 0 END

    )                                AS risk_score,
    'open'                          AS status,
    'Account made ' || COUNT(*)::TEXT ||
    ' transactions between $5K-$9,999 spread over ' ||
    (MAX(DATE(t.txn_date)) - MIN(DATE(t.txn_date)))::TEXT ||
    ' days. From ' || MIN(DATE(t.txn_date))::TEXT ||
    ' to ' || MAX(DATE(t.txn_date))::TEXT   AS description
FROM transactions t
JOIN accounts a ON a.account_id=t.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.amount BETWEEN 5000 AND 9999
GROUP BY a.account_id,c.customer_id,c.full_name,c.risk_rating,c.pep_flag
HAVING COUNT(*) >=3 AND MAX(DATE(T.txn_date)) - MIN(DATE(t.txn_date)) BETWEEN 3 AND 5
;


-- Query 1.3: Same customer depositing cash at 3+ different branches on the same day
--===================================================================================

SELECT
c.customer_id,
c.full_name,
DATE(t.txn_date) AS txn_day,
COUNT(DISTINCT a.branch_code)       AS branch_count,
STRING_AGG(DISTINCT a.branch_code, ', ') AS branches_used
FROM transactions t
JOIN accounts a   ON t.account_id=a.account_id
JOIN customers c  ON a.customer_id=c.customer_id
WHERE t.txn_type='deposit'
GROUP BY c.customer_id,c.full_name,DATE(t.txn_date)
HAVING COUNT(DISTINCT a.branch_code)>=3
ORDER BY
branch_count DESC
;

-- INSERT INTO ALERTS for Same customer depositing cash at 3+ different branches on the same day

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
    MIN(t.txn_id)                   AS txn_id,
    a.account_id,
    c.customer_id,
    'Branch Hopping'        AS alert_type,
    'structuring'                   AS alert_category,
    NOW()                           AS alert_date,
    (
        CASE
            WHEN COUNT(DISTINCT a.branch_code)>=5 THEN 85
            WHEN COUNT(DISTINCT a.branch_code)=4 THEN 80
            WHEN COUNT(DISTINCT a.branch_code)=3 THEN 75
            ELSE 0
        END
        +
        CASE
            WHEN c.risk_rating = 'high' THEN 10
            WHEN c.risk_rating = 'medium' THEN 10
            ELSE 0
        END
        +
        CASE 
            WHEN SUM(t.amount)>5000 THEN 10
            WHEN SUM(T.AMOUNT)>2000 THEN 5
            ELSE 0
        END
    )                               AS risk_score,
    'open'                          AS status,
    'Customer made deposits at' || 
    COUNT(DISTINCT a.branch_code)::TEXT ||
    'different branches on'||
    DATE(t.txn_date)::TEXT ||
    ' .Total amount: $' ||
    SUM(t.amount)::TEXT             AS description
FROM transactions t
JOIN accounts a   ON t.account_id=a.account_id
JOIN customers c  ON a.customer_id=c.customer_id
WHERE t.txn_type='deposit'
GROUP BY a.account_id,c.customer_id,c.full_name,DATE(t.txn_date)
HAVING COUNT(DISTINCT a.branch_code)>=3
;





-- 1.4: Transactions with exact round numbers like $10,000 / $50,000 / $100,000
--==============================================================================

SELECT
    c.customer_id,
    c.full_name,
    t.txn_type,
    t.amount,
    DATE(t.txn_date)        AS txn_day,
    t.counterparty_country,
    COUNT(t.txn_id)         AS txn_count
FROM transactions t
JOIN accounts a     ON t.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE MOD(t.amount, 10000) = 0
AND   t.amount >= 10000
GROUP BY c.customer_id, c.full_name, t.txn_type,
         t.amount, DATE(t.txn_date), t.counterparty_country
ORDER BY t.amount DESC;

-- INSERT INTO ALERTS for exact round number transaction

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
    a.account_id,
    c.customer_id,
    'Round Number Transaction'    AS alert_type,
    'structuring'                       AS alert_category,
    NOW()                               AS alert_date,
    (
        -- Base score by amount size
        CASE
            WHEN t.amount >= 100000 THEN 80
            WHEN t.amount >= 50000  THEN 75
            WHEN t.amount >= 10000  THEN 70
            ELSE 65
        END
        +
        -- Customer risk rating
        CASE
            WHEN c.risk_rating = 'high'   THEN 10
            WHEN c.risk_rating = 'medium' THEN 5
            ELSE 0
        END
        +
        -- PEP flag
        CASE WHEN c.pep_flag = TRUE THEN 10 ELSE 0 END
    )                                   AS risk_score,
    'open'                              AS status,
    'Account made an exact round number transaction of $' ||
    t.amount::TEXT ||
    ' on ' ||
    DATE(t.txn_date)::TEXT              AS description
FROM transactions t
JOIN accounts a     ON t.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE MOD(t.amount, 10000) = 0
AND   t.amount >= 10000;





--1.5: Amounts repeatedly ending in $9,999 / $4,999 / $2,999 (just-below threshold)
--=================================================================================

SELECT
c.customer_id,
c.full_name,
count(*) as txn_count,
SUM(t.amount)   AS total_amount,
MIN(t.txn_date)     AS min_txn_date,
MAX(t.txn_date)     AS mx_txn_date
FROM transactions t
JOIN accounts a ON t.account_id=a.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.amount IN (9999,4999,2999) 
--AND t.txn_date>= CURRENT_DATE - INTERVAL '30 days' -- USE IT FOR PRODUCTION
AND t.txn_date >= '2024-01-01' AND t.txn_date <= '2024-12-31' -- according to the current data
GROUP BY c.customer_id,c.full_name
HAVING COUNT(*)>=2
ORDER BY txn_count DESC
;

-- INSERT INTO ALERTS for just-below threshold amount

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
    MIN(t.txn_id)                   AS txn_id,
    a.account_id,
    c.customer_id,
    'just-below threshold'        AS alert_type,
    'structuring'                   AS alert_category,
    NOW()                           AS alert_date,
    (
        CASE
            WHEN COUNT(*) >= 5 THEN 85
            WHEN COUNT(*) >= 3 THEN 80
            ELSE 75
        END
        +
        CASE
            WHEN c.risk_rating = 'high'   THEN 10
            WHEN c.risk_rating = 'medium' THEN 5
            ELSE 0
        END
        +
        CASE WHEN c.pep_flag = TRUE THEN 10 ELSE 0 END
    )                                   AS risk_score,
    'open'                          AS status,
        'Customer made ' || COUNT(*)::TEXT ||
    ' just-below threshold transactions totalling $' ||
    SUM(t.amount)::TEXT                 AS description
FROM transactions t
JOIN accounts a     ON t.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE t.amount IN (9999,4999,2999) 
--AND t.txn_date>= CURRENT_DATE - INTERVAL '30 days' -- USE IT FOR PRODUCTION
AND t.txn_date >= '2024-01-01' AND t.txn_date <= '2024-12-31' -- according to the current data
GROUP BY c.customer_id,c.full_name,a.account_id,c.risk_rating, c.pep_flag
HAVING COUNT(*)>=2
;

