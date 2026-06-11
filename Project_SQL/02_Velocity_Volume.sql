--CATEGORY 2: Velocity & Volume (5 checks)
--****************************************
--2.1 — Last 7 days transaction volume is 3x the 30-day daily average
--===================================================================
WITH latest_txn_day AS
(
    SELECT 
    MAX(DATE(txn_date)) AS recent_txn_day
    FROM
    transactions
),
monthly_avg_amount AS
(
    SELECT
    account_id,
    SUM(amount)/30.0    AS avg_daily_amount
    FROM
    transactions
    WHERE txn_date >= ((select recent_txn_day from latest_txn_day) - INTERVAL '29 days')
    GROUP BY account_id
)
,
last_7_days AS
(
    SELECT
    account_id,
    SUM(amount)/7.0    AS recent_daily_avg
    FROM
    transactions
    WHERE DATE(txn_date) >= ((select recent_txn_day from latest_txn_day) - INTERVAL '6 days')
    GROUP BY account_id
)

SELECT
a.account_id,
c.full_name,
m.avg_daily_amount,
l.recent_daily_avg,
ROUND(l.recent_daily_avg/NULLIF(m.avg_daily_amount,0),2)        AS spike_ratio
FROM
last_7_days AS l
JOIN monthly_avg_amount m ON l.account_id=m.account_id
JOIN accounts a ON l.account_id=a.account_id
JOIN customers c ON a.customer_id=c.customer_id
WHERE l.recent_daily_avg/NULLIF(m.avg_daily_amount,0)>=3
ORDER BY spike_ratio DESC
;

--Insert into Alerts table for detection Last 7 days transaction volume is 3x the 30-day daily average

WITH latest_txn_day AS (
    SELECT MAX(DATE(txn_date)) AS recent_txn_day
    FROM transactions
),
monthly_avg_amount AS (
    SELECT
        account_id,
        SUM(amount) / 30.0      AS avg_daily_amount
    FROM transactions
    WHERE txn_date >= ((SELECT recent_txn_day FROM latest_txn_day) - INTERVAL '29 days')
    GROUP BY account_id
),
last_7_days AS (
    SELECT
        account_id,
        SUM(amount) / 7.0       AS recent_daily_avg
    FROM transactions
    WHERE DATE(txn_date) >= ((SELECT recent_txn_day FROM latest_txn_day) - INTERVAL '6 days')
    GROUP BY account_id
)
INSERT INTO alerts(
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
Min(t.txn_id)                         AS txn_id,
a.account_id,
c.customer_id,
'Transaction Volume Spike'          AS alert_type,
'velocity'                          AS alert_category,
NOW()                               AS alert_date,
(
    CASE
    WHEN ROUND(l.recent_daily_avg / NULLIF(m.avg_daily_amount, 0), 2) >= 10 THEN 90
    WHEN ROUND(l.recent_daily_avg / NULLIF(m.avg_daily_amount, 0), 2) >= 5  THEN 80
    WHEN ROUND(l.recent_daily_avg / NULLIF(m.avg_daily_amount, 0), 2) >= 3  THEN 70
    ELSE 65
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
'open'                              AS status,
'spike ratio:'||ROUND(l.recent_daily_avg/NULLIF(m.avg_daily_amount,0),2)::TEXT||
ROUND(l.recent_daily_avg,2)::TEXT||ROUND(m.avg_daily_amount,2)::TEXT         AS description
FROM transactions t
JOIN accounts a ON a.account_id=t.account_id
JOIN customers c ON c.customer_id=a.customer_id
JOIN last_7_days l ON l.account_id=t.account_id
JOIN monthly_avg_amount m ON m.account_id=t.account_id
WHERE l.recent_daily_avg/NULLIF(m.avg_daily_amount,0)>=3
GROUP BY a.account_id, c.customer_id, c.full_name,
         c.risk_rating, c.pep_flag,
         l.recent_daily_avg, m.avg_daily_amount;
;




--2.2 — Number of transactions this week is 3x the monthly average count
--=======================================================================
WITH latest_txn_date AS
(
SELECT
MAX(txn_date) as recent_txn_day
FROM
transactions
)
,
monthly_txn_count AS
(
SELECT
account_id,
count(*)/30.0                AS avg_daily_count
FROM
transactions
WHERE DATE(txn_date)>=((SELECT recent_txn_day FROM latest_txn_date)- INTERVAL '29 days')
GROUP BY account_id
)
,
last_7_days_count AS
(
SELECT
account_id,
count(*)/7.0                AS recent_daily_avg_count
FROM
transactions
WHERE DATE(txn_date)>=((SELECT recent_txn_day FROM latest_txn_date)- INTERVAL '6 days')
GROUP BY account_id
)
SELECT
a.account_id,
c.full_name,
m.avg_daily_count,
l.recent_daily_avg_count,
ROUND(l.recent_daily_avg_count/NULLIF(m.avg_daily_count,0),2)         AS spike_ratio

FROM
last_7_days_count AS l
JOIN monthly_txn_count m ON l.account_id=m.account_id
JOIN accounts a ON l.account_id=a.account_id
JOIN customers c ON a.customer_id=c.customer_id
WHERE l.recent_daily_avg_count/NULLIF(m.avg_daily_count,0)>=3
ORDER BY spike_ratio DESC
;


--Insert into Alerts table for detection Number of transactions this week is 3x the monthly average count

WITH latest_txn_date AS
(
SELECT
MAX(txn_date) as recent_txn_day
FROM
transactions
)
,
monthly_txn_count AS
(
SELECT
account_id,
count(*)/30.0                AS avg_daily_count
FROM
transactions
WHERE DATE(txn_date)>=((SELECT recent_txn_day FROM latest_txn_date)- INTERVAL '29 days')
GROUP BY account_id
)
,
last_7_days_count AS
(
SELECT
account_id,
count(*)/7.0                AS recent_daily_avg_count
FROM
transactions
WHERE DATE(txn_date)>=((SELECT recent_txn_day FROM latest_txn_date)- INTERVAL '6 days')
GROUP BY account_id
)

INSERT INTO alerts(
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
MIN(t.txn_id)                        AS txn_id,
a.account_id,
c.customer_id,
'Transaction Count Spike'          AS alert_type,
'velocity'                          AS alert_category,
NOW()                               AS alert_date,
(
    CASE
    WHEN ROUND(l.recent_daily_avg_count / NULLIF(m.avg_daily_count, 0), 2) >= 10 THEN 90
    WHEN ROUND(l.recent_daily_avg_count / NULLIF(m.avg_daily_count, 0), 2) >= 5  THEN 80
    WHEN ROUND(l.recent_daily_avg_count / NULLIF(m.avg_daily_count  , 0), 2) >= 3  THEN 70
    ELSE 65
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
'open'                              AS status,
' spike ratio:'||ROUND(l.recent_daily_avg_count/NULLIF(m.avg_daily_count,0),2)::TEXT||
' Daily average count: '||ROUND(l.recent_daily_avg_count,2)::TEXT||
' Monthly average count:'||ROUND(m.avg_daily_count,2)::TEXT         AS description
FROM
transactions t
JOIN accounts a  ON t.account_id=a.account_id
JOIN customers c ON c.customer_id=a.customer_id
JOIN last_7_days_count l ON l.account_id=t.account_id
JOIN monthly_txn_count m ON m.account_id=t.account_id
WHERE l.recent_daily_avg_count/NULLIF(m.avg_daily_count,0)>=3
GROUP BY a.account_id, c.customer_id, c.full_name,
         c.risk_rating, c.pep_flag,
         l.recent_daily_avg_count, m.avg_daily_count;

;


--2.3 — Account had zero activity for 90+ days and is suddenly active
--=======================================================================
WITH txn_ranked AS (
    SELECT
        account_id,
        txn_date,
        ROW_NUMBER() OVER (
            PARTITION BY account_id 
            ORDER BY txn_date DESC
        )                       AS rn
    FROM transactions
),
latest_txn AS (
    SELECT account_id, txn_date AS latest_txn_day
    FROM txn_ranked
    WHERE rn = 1
),
prev_txn AS (
    SELECT account_id, txn_date AS prev_txn_day
    FROM txn_ranked
    WHERE rn = 2
)
SELECT
    a.account_id,
    c.full_name,
    l.latest_txn_day,
    p.prev_txn_day,
    DATE(l.latest_txn_day) - DATE(p.prev_txn_day)  AS days_gap
FROM latest_txn l
JOIN prev_txn p     ON l.account_id  = p.account_id
JOIN accounts a     ON l.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE DATE(l.latest_txn_day) - DATE(p.prev_txn_day) > 60
ORDER BY days_gap DESC;

--Insert into Alerts table for detection of Account had zero activity for 90+ days and is suddenly active
WITH txn_ranked AS (
    SELECT
        account_id,
        txn_date,
        ROW_NUMBER() OVER (
            PARTITION BY account_id
            ORDER BY txn_date DESC
        )                       AS rn
    FROM transactions
),
latest_txn AS (
    SELECT account_id, txn_date AS latest_txn_day
    FROM txn_ranked
    WHERE rn = 1
),
prev_txn AS (
    SELECT account_id, txn_date AS prev_txn_day
    FROM txn_ranked
    WHERE rn = 2
)
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
    NULL                                AS txn_id,
    a.account_id,
    c.customer_id,
    'Dormant Account Reactivation'      AS alert_type,
    'velocity'                          AS alert_category,
    NOW()                               AS alert_date,
    LEAST(
        (
            CASE
                WHEN DATE(l.latest_txn_day) - DATE(p.prev_txn_day) > 365 THEN 90
                WHEN DATE(l.latest_txn_day) - DATE(p.prev_txn_day) > 180 THEN 85
                WHEN DATE(l.latest_txn_day) - DATE(p.prev_txn_day) > 90  THEN 80
                ELSE 70
            END
            +
            CASE
                WHEN c.risk_rating = 'high'   THEN 10
                WHEN c.risk_rating = 'medium' THEN 5
                ELSE 0
            END
            +
            CASE WHEN c.pep_flag = TRUE THEN 10 ELSE 0 END
        ), 100
    )                                   AS risk_score,
    'open'                              AS status,
    'Dormant account reactivated after ' ||
    (DATE(l.latest_txn_day) - DATE(p.prev_txn_day))::TEXT ||
    ' days. Previous activity: ' || DATE(p.prev_txn_day)::TEXT ||
    '. Latest activity: ' || DATE(l.latest_txn_day)::TEXT  AS description
FROM latest_txn l
JOIN prev_txn p     ON l.account_id  = p.account_id
JOIN accounts a     ON l.account_id  = a.account_id
JOIN customers c    ON a.customer_id = c.customer_id
WHERE DATE(l.latest_txn_day) - DATE(p.prev_txn_day) > 60;






--2.4 — Any single transaction above $50,000 or $100,000
--=======================================================================
SELECT
a.account_id,
t.txn_id,
t.amount,
c.full_name,
DATE(t.txn_date)        AS txn_day,
t.txn_type
FROM
transactions t
JOIN accounts a ON t.account_id=a.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.amount>50000
ORDER BY
t.amount DESC
;

--Insert into Alerts table for detection of any single transaction above $50,000 or $100,000

INSERT INTO alerts(
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
t.txn_id ,
a.account_id,
c.customer_id,
'Large Single Transaction'          AS alert_type,
'velocity'                          AS alert_category,
NOW()                               AS alert_date,
(
    CASE
    WHEN t.amount>= 100000 THEN 80
    WHEN t.amount>=50000 THEN 70
    ELSE 10
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
'open'                              AS status,
'Transaction amount is $'|| t.amount::TEXT     AS description
FROM
transactions t
JOIN accounts a ON a.account_id=t.account_id
JOIN customers c ON c.customer_id=a.customer_id
WHERE t.amount>50000
;


--2.5 — Money deposited and withdrawn from same account within 24–48 hours
--=======================================================================
/*WITH latest_txn_time AS
(
    SELECT DATE(MAX(txn_date)) AS recent_txn_time
    FROM transactions
)
,*/
WITH deposits AS
(
SELECT
account_id,
txn_date        AS deposit_date, 
amount          AS deposit_amount
FROM transactions
WHERE txn_type='deposit'
)
,
withdrawals AS
(
SELECT
account_id,
txn_date        AS withdrawal_date, 
amount          AS withdrawal_amount
FROM transactions
WHERE txn_type='withdrawal'
)

SELECT
a.account_id,
c.full_name,
d.deposit_date,
d.deposit_amount,
w.withdrawal_date,
w.withdrawal_amount,
EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 AS hours_between
FROM
deposits d
JOIN withdrawals w ON d.account_id=w.account_id
JOIN accounts a ON a.account_id=d.account_id
JOIN customers c ON a.customer_id=c.customer_id
WHERE w.withdrawal_date > d.deposit_date
AND
EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 48
ORDER BY hours_between
;

--Insert into Alerts table for detection of Money deposited and withdrawn from same account within 24–48 hours

WITH deposits AS
(
SELECT
txn_id,
account_id,
txn_date        AS deposit_date, 
amount          AS deposit_amount
FROM transactions
WHERE txn_type='deposit'
)
,
withdrawals AS
(
SELECT
txn_id,
account_id,
txn_date        AS withdrawal_date, 
amount          AS withdrawal_amount
FROM transactions
WHERE txn_type='withdrawal'
)
INSERT INTO alerts(
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
d.txn_id ,
a.account_id,
c.customer_id,
'Rapid Fund Movement'              AS alert_type,
'velocity'                          AS alert_category,
NOW()                               AS alert_date,
(
    CASE
        WHEN EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 6  THEN 90
        WHEN EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 12 THEN 85
        WHEN EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 24 THEN 80
        WHEN EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 48 THEN 75
        ELSE 70
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
'open'                              AS status,
'Money deposited and withdrawn betseen '|| 
ROUND((EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600)::NUMERIC,2)::TEXT ||
 ' hours. Deposit: $' || d.deposit_amount::TEXT ||
    ' Withdrawal: $' || w.withdrawal_amount::TEXT    AS description
FROM deposits d
JOIN withdrawals w   ON d.account_id    = w.account_id
JOIN accounts a      ON d.account_id    = a.account_id
JOIN customers c     ON a.customer_id   = c.customer_id
WHERE w.withdrawal_date > d.deposit_date
AND   EXTRACT(EPOCH FROM (w.withdrawal_date - d.deposit_date))/3600 <= 48
;

















