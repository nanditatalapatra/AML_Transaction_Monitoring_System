-- =============================================
-- AML TRANSACTION MONITORING
-- FILE 1: SCHEMA
-- =============================================

-- Drop tables if they exist (clean start)
DROP TABLE IF EXISTS case_management CASCADE;
DROP TABLE IF EXISTS alerts CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS watchlist CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- =============================================
-- TABLE 1: CUSTOMERS
-- =============================================
CREATE TABLE customers (
    customer_id         SERIAL PRIMARY KEY,
    full_name           VARCHAR(100)    NOT NULL,
    date_of_birth       DATE,
    gender              VARCHAR(10),
    country_of_origin   VARCHAR(50),
    nationality         VARCHAR(50),
    address             VARCHAR(200),
    city                VARCHAR(50),
    state               VARCHAR(50),
    zip_code            VARCHAR(20),
    email               VARCHAR(100),
    phone               VARCHAR(20),
    occupation          VARCHAR(100),
    annual_income       NUMERIC(15,2),
    kyc_status          VARCHAR(20)     CHECK (kyc_status IN ('verified','pending','failed')),
    kyc_verified_date   DATE,
    risk_rating         VARCHAR(10)     CHECK (risk_rating IN ('low','medium','high')),
    pep_flag            BOOLEAN         DEFAULT FALSE,
    pep_category        VARCHAR(50),    -- 'domestic','foreign','international_org'
    created_at          TIMESTAMP       DEFAULT NOW()
);

-- =============================================
-- TABLE 2: ACCOUNTS
-- =============================================
CREATE TABLE accounts (
    account_id          SERIAL PRIMARY KEY,
    customer_id         INT             REFERENCES customers(customer_id),
    account_type        VARCHAR(20)     CHECK (account_type IN ('checking','savings','wire','investment')),
    account_status      VARCHAR(20)     CHECK (account_status IN ('active','frozen','closed')),
    open_date           DATE,
    closed_date         DATE,
    currency            VARCHAR(5),
    branch_code         VARCHAR(10),
    branch_city         VARCHAR(50),
    current_balance     NUMERIC(15,2)   DEFAULT 0.00
);

-- =============================================
-- TABLE 3: TRANSACTIONS
-- =============================================
CREATE TABLE transactions (
    txn_id                  SERIAL PRIMARY KEY,
    account_id              INT             REFERENCES accounts(account_id),
    txn_date                TIMESTAMP       NOT NULL,
    txn_type                VARCHAR(20)     CHECK (txn_type IN ('deposit','withdrawal','wire','transfer')),
    amount                  NUMERIC(15,2)   NOT NULL,
    currency                VARCHAR(5),
    counterparty_name       VARCHAR(100),
    counterparty_account    VARCHAR(50),
    counterparty_bank       VARCHAR(100),
    counterparty_country    VARCHAR(50),
    channel                 VARCHAR(20)     CHECK (channel IN ('ATM','online','branch','mobile','wire')),
    purpose                 VARCHAR(200),
    status                  VARCHAR(20)     CHECK (status IN ('completed','pending','reversed','failed')),
    reference_no            VARCHAR(50)
);

-- =============================================
-- TABLE 4: WATCHLIST
-- =============================================
CREATE TABLE watchlist (
    watchlist_id        SERIAL PRIMARY KEY,
    entity_name         VARCHAR(100)    NOT NULL,
    entity_type         VARCHAR(20)     CHECK (entity_type IN ('individual','organization','country')),
    list_source         VARCHAR(30)     CHECK (list_source IN ('OFAC','UN','EU','FATF','FBI')),
    risk_level          VARCHAR(10)     CHECK (risk_level IN ('critical','high','medium')),
    country             VARCHAR(50),
    reason              VARCHAR(200),
    added_date          DATE,
    is_active           BOOLEAN         DEFAULT TRUE
);

-- =============================================
-- TABLE 5: ALERTS
-- =============================================
CREATE TABLE alerts (
    alert_id            SERIAL PRIMARY KEY,
    txn_id              INT             REFERENCES transactions(txn_id),
    account_id          INT             REFERENCES accounts(account_id),
    customer_id         INT             REFERENCES customers(customer_id),
    alert_type          VARCHAR(100),
    alert_category      VARCHAR(50),    -- 'structuring','velocity','sanctions','pep','kyc','geographic','pattern'
    alert_date          TIMESTAMP       DEFAULT NOW(),
    risk_score          INT             CHECK (risk_score BETWEEN 0 AND 100),
    status              VARCHAR(20)     CHECK (status IN ('open','under_review','closed','escalated')),
    description         TEXT
);

-- =============================================
-- TABLE 6: CASE MANAGEMENT
-- =============================================
CREATE TABLE case_management (
    case_id             SERIAL PRIMARY KEY,
    alert_id            INT             REFERENCES alerts(alert_id),
    analyst_id          INT,
    analyst_name        VARCHAR(100),
    opened_date         DATE,
    closed_date         DATE,
    outcome             VARCHAR(30)     CHECK (outcome IN ('SAR_filed','no_action','escalated','pending')),
    sar_reference       VARCHAR(50),
    notes               TEXT
);
