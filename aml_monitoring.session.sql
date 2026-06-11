select * from accounts where account_id=13;
select * from transactions where account_id=13;
select count(*) from customers;


DELETE FROM alerts;
select * from alerts;
select * from case_management;

TRUNCATE TABLE case_management, alerts;

DELETE FROM alerts
WHERE alert_type = 'Exact round number transaction';

CURRENT_DATE+5;

select DATE(txn_date),(DATE(txn_date)-1) AS Prev_txn_day from transactions t
ORDER BY DATE(txn_date) DESC;

--------------

WITH txn_ranked AS (
    SELECT
        account_id,
        txn_date,
        ROW_NUMBER() OVER (
            PARTITION BY account_id
            ORDER BY txn_date DESC
        ) AS rn
    FROM transactions
),
latest_txn AS (
    SELECT account_id, txn_date AS latest_txn_day
    FROM txn_ranked WHERE rn = 1
),
prev_txn AS (
    SELECT account_id, txn_date AS prev_txn_day
    FROM txn_ranked WHERE rn = 2
)
SELECT
    a.account_id,
    c.full_name,
    DATE(l.latest_txn_day)                              AS latest_txn,
    DATE(p.prev_txn_day)                                AS prev_txn,
    DATE(l.latest_txn_day) - DATE(p.prev_txn_day)      AS days_gap
FROM latest_txn l
JOIN prev_txn p  ON l.account_id  = p.account_id
JOIN accounts a  ON l.account_id  = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
ORDER BY days_gap DESC;