-- =============================================
-- AML TRANSACTION MONITORING
-- FILE 2: SAMPLE DATA
-- =============================================

-- =============================================
-- INSERT: CUSTOMERS (20 records)
-- =============================================
INSERT INTO customers (full_name, date_of_birth, gender, country_of_origin, nationality, address, city, state, zip_code, email, phone, occupation, annual_income, kyc_status, kyc_verified_date, risk_rating, pep_flag, pep_category) VALUES

-- Low risk customers
('Arjun Mehta',         '1985-03-12', 'Male',   'India',          'Indian',       '123 Oak Street',         'San Jose',     'CA', '95101', 'arjun.mehta@email.com',       '408-111-1001', 'Software Engineer',        95000.00,  'verified', '2023-01-15', 'low',    FALSE, NULL),
('Maria Gonzalez',      '1990-07-22', 'Female', 'Mexico',         'American',     '456 Maple Ave',          'Los Angeles',  'CA', '90001', 'maria.g@email.com',           '213-111-1002', 'Nurse',                    72000.00,  'verified', '2023-02-20', 'low',    FALSE, NULL),
('James Carter',        '1978-11-05', 'Male',   'USA',            'American',     '789 Pine Road',          'Chicago',      'IL', '60601', 'james.c@email.com',           '312-111-1003', 'Accountant',               85000.00,  'verified', '2023-03-10', 'low',    FALSE, NULL),
('Priya Sharma',        '1992-04-18', 'Female', 'India',          'Indian',       '321 Elm Street',         'San Francisco','CA', '94102', 'priya.s@email.com',           '415-111-1004', 'Data Analyst',             88000.00,  'verified', '2023-04-05', 'low',    FALSE, NULL),
('Robert Thompson',     '1970-09-30', 'Male',   'USA',            'American',     '654 Cedar Blvd',         'New York',     'NY', '10001', 'robert.t@email.com',          '212-111-1005', 'Teacher',                  65000.00,  'verified', '2023-05-12', 'low',    FALSE, NULL),

-- Medium risk customers
('Ana Pereira',         '1988-06-14', 'Female', 'Brazil',         'Brazilian',    '987 Walnut Lane',        'Miami',        'FL', '33101', 'ana.p@email.com',             '305-111-1006', 'Business Owner',           120000.00, 'pending',  NULL,         'medium', FALSE, NULL),
('Chen Wei',            '1982-12-25', 'Male',   'China',          'Chinese',      '147 Birch Court',        'San Francisco','CA', '94103', 'chen.w@email.com',            '415-111-1007', 'Import/Export Trader',     150000.00, 'verified', '2022-08-15', 'medium', FALSE, NULL),
('Fatima Al-Hassan',    '1995-02-08', 'Female', 'UAE',            'Emirati',      '258 Spruce Drive',       'Houston',      'TX', '77001', 'fatima.h@email.com',          '713-111-1008', 'Real Estate Agent',        130000.00, 'verified', '2023-06-20', 'medium', FALSE, NULL),
('Carlos Mendoza',      '1975-08-19', 'Male',   'Colombia',       'Colombian',    '369 Ash Avenue',         'Dallas',       'TX', '75201', 'carlos.m@email.com',          '214-111-1009', 'Consultant',               110000.00, 'verified', '2022-11-30', 'medium', FALSE, NULL),
('Natasha Ivanova',     '1987-05-27', 'Female', 'Russia',         'Russian',      '741 Poplar Street',      'Seattle',      'WA', '98101', 'natasha.i@email.com',         '206-111-1010', 'Jewelry Dealer',           140000.00, 'verified', '2022-09-18', 'medium', FALSE, NULL),

-- High risk customers
('Viktor Sokolov',      '1965-01-15', 'Male',   'Russia',         'Russian',      '852 Redwood Blvd',       'New York',     'NY', '10002', 'viktor.s@email.com',          '212-111-1011', 'Government Official',      500000.00, 'verified', '2021-03-10', 'high',   TRUE,  'foreign'),
('Mohammed Al-Rashid',  '1960-10-03', 'Male',   'Saudi Arabia',   'Saudi',        '963 Magnolia Court',     'Washington',   'DC', '20001', 'mohammed.r@email.com',        '202-111-1012', 'Ambassador',               800000.00, 'verified', '2021-05-22', 'high',   TRUE,  'foreign'),
('Elena Kozlov',        '1972-07-11', 'Female', 'Ukraine',        'Ukrainian',    '159 Cypress Lane',       'Chicago',      'IL', '60602', 'elena.k@email.com',           '312-111-1013', 'Minister of Finance',      600000.00, 'verified', '2021-07-14', 'high',   TRUE,  'domestic'),
('Zhou Xiaoming',       '1968-03-22', 'Male',   'China',          'Chinese',      '357 Hickory Drive',      'Los Angeles',  'CA', '90002', 'zhou.x@email.com',            '213-111-1014', 'State Enterprise CEO',     750000.00, 'verified', '2021-09-05', 'high',   TRUE,  'foreign'),
('Ibrahim Okonkwo',     '1980-11-30', 'Male',   'Nigeria',        'Nigerian',     '486 Willow Way',         'Atlanta',      'GA', '30301', 'ibrahim.o@email.com',         '404-111-1015', 'Crypto Trader',            200000.00, 'pending',  NULL,         'high',   FALSE, NULL),

-- KYC failed / suspicious customers
('Shell Corp LLC',      '1990-01-01', 'Male',   'Cayman Islands', 'Unknown',      '000 Offshore Plaza',     'George Town',  'CI', '00000', 'shell@corp.com',              '000-000-0000', 'Investment Company',       0.00,      'failed',   NULL,         'high',   FALSE, NULL),
('Victor Sokolov',      '1965-01-15', 'Male',   'Russia',         'Russian',      '852 Redwood Blvd',       'New York',     'NY', '10002', 'victor.s@email.com',          '212-111-1017', 'Government Official',      500000.00, 'verified', '2021-03-10', 'high',   TRUE,  'foreign'),
('Ali Hassan',          '1978-04-16', 'Male',   'Iran',           'Iranian',      '753 Palm Street',        'Detroit',      'MI', '48201', 'ali.h@email.com',             '313-111-1018', 'Money Exchange',           300000.00, 'failed',   NULL,         'high',   FALSE, NULL),
('Dong-Hyun Park',      '1983-09-09', 'Male',   'North Korea',    'North Korean', '246 Grove Avenue',       'Los Angeles',  'CA', '90003', 'dong.p@email.com',            '213-111-1019', 'Unknown',                  0.00,      'failed',   NULL,         'high',   FALSE, NULL),
('Sandra Mitchell',     '1993-12-01', 'Female', 'USA',            'American',     '135 Sunset Blvd',        'Phoenix',      'AZ', '85001', 'sandra.m@email.com',          '602-111-1020', 'Waitress',                 28000.00,  'verified', '2023-08-01', 'low',    FALSE, NULL);


-- =============================================
-- INSERT: ACCOUNTS (30 records)
-- =============================================
INSERT INTO accounts (customer_id, account_type, account_status, open_date, currency, branch_code, branch_city, current_balance) VALUES

-- Arjun Mehta (customer 1) - low risk
(1,  'checking',    'active',  '2020-01-10', 'USD', 'BR001', 'San Jose',      15000.00),

-- Maria Gonzalez (customer 2) - low risk
(2,  'savings',     'active',  '2019-06-15', 'USD', 'BR002', 'Los Angeles',   8000.00),

-- James Carter (customer 3) - low risk
(3,  'checking',    'active',  '2018-03-20', 'USD', 'BR003', 'Chicago',       22000.00),

-- Priya Sharma (customer 4) - low risk
(4,  'checking',    'active',  '2021-09-01', 'USD', 'BR001', 'San Francisco', 31000.00),

-- Robert Thompson (customer 5) - low risk
(5,  'savings',     'active',  '2017-11-12', 'USD', 'BR004', 'New York',      12000.00),

-- Ana Pereira (customer 6) - medium risk, KYC pending
(6,  'checking',    'active',  '2023-11-01', 'USD', 'BR005', 'Miami',         45000.00),

-- Chen Wei (customer 7) - medium risk
(7,  'checking',    'active',  '2019-04-18', 'USD', 'BR001', 'San Francisco', 75000.00),
(7,  'wire',        'active',  '2020-07-22', 'USD', 'BR001', 'San Francisco', 120000.00),

-- Fatima Al-Hassan (customer 8) - medium risk
(8,  'checking',    'active',  '2021-02-14', 'USD', 'BR006', 'Houston',       55000.00),

-- Carlos Mendoza (customer 9) - medium risk
(9,  'checking',    'active',  '2020-08-30', 'USD', 'BR007', 'Dallas',        38000.00),
(9,  'savings',     'active',  '2021-01-15', 'USD', 'BR007', 'Dallas',        62000.00),

-- Natasha Ivanova (customer 10) - medium risk
(10, 'checking',    'active',  '2018-12-05', 'USD', 'BR008', 'Seattle',       90000.00),

-- Viktor Sokolov (customer 11) - HIGH RISK PEP
(11, 'checking',    'active',  '2020-05-10', 'USD', 'BR004', 'New York',      250000.00),
(11, 'wire',        'active',  '2020-05-10', 'EUR', 'BR004', 'New York',      180000.00),
(11, 'savings',     'active',  '2021-03-18', 'GBP', 'BR004', 'New York',      95000.00),

-- Mohammed Al-Rashid (customer 12) - HIGH RISK PEP
(12, 'wire',        'active',  '2019-11-20', 'USD', 'BR004', 'Washington',    500000.00),
(12, 'checking',    'active',  '2020-01-05', 'EUR', 'BR004', 'Washington',    320000.00),

-- Elena Kozlov (customer 13) - HIGH RISK PEP
(13, 'checking',    'active',  '2020-09-14', 'USD', 'BR003', 'Chicago',       410000.00),

-- Zhou Xiaoming (customer 14) - HIGH RISK PEP
(14, 'wire',        'active',  '2019-07-08', 'USD', 'BR002', 'Los Angeles',   680000.00),
(14, 'checking',    'active',  '2020-02-20', 'CNY', 'BR002', 'Los Angeles',   220000.00),

-- Ibrahim Okonkwo (customer 15) - HIGH RISK, KYC pending
(15, 'checking',    'active',  '2023-12-01', 'USD', 'BR009', 'Atlanta',       18000.00),

-- Shell Corp LLC (customer 16) - HIGH RISK, KYC failed
(16, 'wire',        'active',  '2024-01-02', 'USD', 'BR004', 'New York',      0.00),

-- Victor Sokolov - fuzzy match (customer 17)
(17, 'checking',    'active',  '2020-05-10', 'USD', 'BR004', 'New York',      175000.00),

-- Ali Hassan (customer 18) - KYC failed
(18, 'checking',    'frozen',  '2022-06-10', 'USD', 'BR003', 'Detroit',       5000.00),

-- Dong-Hyun Park (customer 19) - KYC failed
(19, 'checking',    'frozen',  '2023-01-15', 'USD', 'BR002', 'Los Angeles',   2000.00),

-- Sandra Mitchell (customer 20) - low risk, low income
(20, 'checking',    'active',  '2024-01-10', 'USD', 'BR010', 'Phoenix',       500.00),
(20, 'savings',     'active',  '2024-01-10', 'USD', 'BR010', 'Phoenix',       200.00),
(20, 'wire',        'active',  '2024-01-15', 'USD', 'BR010', 'Phoenix',       0.00),
(20, 'investment',  'active',  '2024-01-20', 'USD', 'BR010', 'Phoenix',       0.00),
(20, 'checking',    'active',  '2024-01-25', 'USD', 'BR010', 'Phoenix',       0.00);


-- =============================================
-- INSERT: WATCHLIST (15 records)
-- =============================================
INSERT INTO watchlist (entity_name, entity_type, list_source, risk_level, country, reason, added_date, is_active) VALUES

('Viktor Sokolov',          'individual',   'OFAC',  'critical', 'Russia',         'Sanctioned for financial crimes',              '2020-01-01', TRUE),
('Mohammed Al-Rashid',      'individual',   'UN',    'critical', 'Saudi Arabia',   'Linked to terrorist financing',                '2019-06-15', TRUE),
('Shell Corp LLC',          'organization', 'UN',    'high',     'Cayman Islands', 'Known money laundering vehicle',               '2021-03-10', TRUE),
('Iran',                    'country',      'FATF',  'critical', 'Iran',           'State sponsor of terrorism',                   '2018-01-01', TRUE),
('North Korea',             'country',      'FATF',  'critical', 'North Korea',    'Weapons proliferation and sanctions evasion',  '2018-01-01', TRUE),
('Myanmar',                 'country',      'FATF',  'high',     'Myanmar',        'High risk jurisdiction',                       '2020-02-01', TRUE),
('Dong-Hyun Park',          'individual',   'OFAC',  'critical', 'North Korea',    'Sanctions evasion agent',                      '2022-05-10', TRUE),
('Ali Hassan',              'individual',   'FBI',   'high',     'Iran',           'Suspected hawala operator',                    '2021-11-20', TRUE),
('Cayman Islands',          'country',      'FATF',  'medium',   'Cayman Islands', 'High risk offshore jurisdiction',              '2019-01-01', TRUE),
('Panama',                  'country',      'FATF',  'medium',   'Panama',         'High risk offshore jurisdiction',              '2019-01-01', TRUE),
('British Virgin Islands',  'country',      'FATF',  'medium',   'BVI',            'High risk offshore jurisdiction',              '2019-01-01', TRUE),
('Seychelles',              'country',      'FATF',  'medium',   'Seychelles',     'High risk offshore jurisdiction',              '2019-01-01', TRUE),
('Victor Sokolov',          'individual',   'OFAC',  'critical', 'Russia',         'Alias for Viktor Sokolov',                     '2020-01-01', TRUE),
('Zhou Xiaoming',           'individual',   'EU',    'high',     'China',          'Linked to state-sponsored financial crimes',   '2021-08-15', TRUE),
('Ibrahim Okonkwo',         'individual',   'FBI',   'high',     'Nigeria',        'Suspected crypto laundering network',          '2022-12-01', TRUE);


-- =============================================
-- INSERT: TRANSACTIONS (80 records)
-- =============================================
INSERT INTO transactions (account_id, txn_date, txn_type, amount, currency, counterparty_name, counterparty_account, counterparty_bank, counterparty_country, channel, purpose, status, reference_no) VALUES

-- -----------------------------------------------
-- CATEGORY 1: STRUCTURING - Account 13 (Viktor Sokolov - checking)
-- Three deposits just under $10K on same day
-- -----------------------------------------------
(13, '2024-01-05 09:15:00', 'deposit',    9800.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1001'),
(13, '2024-01-05 12:30:00', 'deposit',    9500.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1002'),
(13, '2024-01-05 15:45:00', 'deposit',    9700.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1003'),

-- Multi-day structuring - Account 10 (Natasha Ivanova)
(12, '2024-01-08 10:00:00', 'deposit',    9900.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1004'),
(12, '2024-01-09 11:00:00', 'deposit',    9850.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1005'),
(12, '2024-01-10 14:00:00', 'deposit',    9600.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1006'),
(12, '2024-01-11 16:00:00', 'deposit',    9750.00,  'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-1007'),

-- Round number transactions - Account 14 (Viktor wire account)
(14, '2024-01-15 10:00:00', 'wire',       50000.00, 'USD', 'Global Trade LLC',    'ACC-99001',    'Cayman National Bank', 'Cayman Islands', 'wire',   'Business payment',         'completed', 'TXN-1008'),
(14, '2024-01-20 11:00:00', 'wire',       100000.00,'USD', 'Offshore Holdings',   'ACC-99002',    'BVI Bank',             'BVI',            'wire',   'Investment transfer',      'completed', 'TXN-1009'),

-- Just-below threshold - Account 6 (Ana Pereira)
(6,  '2024-01-12 09:00:00', 'withdrawal', 9999.00,  'USD', 'Cash Withdrawal',     NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'completed', 'TXN-1010'),
(6,  '2024-01-12 13:00:00', 'withdrawal', 4999.00,  'USD', 'Cash Withdrawal',     NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'completed', 'TXN-1011'),
(6,  '2024-01-13 10:00:00', 'withdrawal', 9999.00,  'USD', 'Cash Withdrawal',     NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'completed', 'TXN-1012'),

-- -----------------------------------------------
-- CATEGORY 2: VELOCITY - Account 21 (Shell Corp)
-- Dormant then sudden activity
-- -----------------------------------------------
(21, '2024-01-25 08:00:00', 'deposit',    200000.00,'USD', 'Unknown Source',      'ACC-88001',    'Panama Bank',          'Panama',         'wire',   'Investment',               'completed', 'TXN-2001'),
(21, '2024-01-25 09:00:00', 'wire',       195000.00,'USD', 'Offshore LLC',        'ACC-88002',    'Seychelles Bank',      'Seychelles',     'wire',   'Transfer',                 'completed', 'TXN-2002'),

-- Velocity spike - Account 8 (Chen Wei wire)
(8,  '2024-01-22 10:00:00', 'wire',       80000.00, 'USD', 'Trade Partner A',     'ACC-77001',    'Hong Kong Bank',       'China',          'wire',   'Trade payment',            'completed', 'TXN-2003'),
(8,  '2024-01-23 11:00:00', 'wire',       75000.00, 'USD', 'Trade Partner B',     'ACC-77002',    'Shanghai Bank',        'China',          'wire',   'Trade payment',            'completed', 'TXN-2004'),
(8,  '2024-01-24 09:00:00', 'wire',       90000.00, 'USD', 'Trade Partner C',     'ACC-77003',    'Beijing Bank',         'China',          'wire',   'Trade payment',            'completed', 'TXN-2005'),
(8,  '2024-01-25 14:00:00', 'wire',       85000.00, 'USD', 'Trade Partner D',     'ACC-77004',    'Shenzhen Bank',        'China',          'wire',   'Trade payment',            'completed', 'TXN-2006'),

-- Large single transaction - Account 16 (Mohammed Al-Rashid)
(16, '2024-01-18 10:00:00', 'wire',       750000.00,'USD', 'Royal Investment Co', 'ACC-55001',    'Swiss Bank AG',        'Switzerland',    'wire',   'Investment transfer',      'completed', 'TXN-2007'),

-- Rapid in/out - Account 20 (Sandra Mitchell - new account)
(20, '2024-01-28 08:00:00', 'deposit',    95000.00, 'USD', 'Unknown Sender',      'ACC-33001',    'Foreign Bank',         'Nigeria',        'wire',   'Personal transfer',        'completed', 'TXN-2008'),
(20, '2024-01-28 10:00:00', 'wire',       93000.00, 'USD', 'Recipient Unknown',   'ACC-33002',    'Panama Bank',          'Panama',         'wire',   'Personal transfer',        'completed', 'TXN-2009'),

-- -----------------------------------------------
-- CATEGORY 3: SANCTIONS - Transactions with Iran/North Korea
-- -----------------------------------------------
(14, '2024-01-10 09:00:00', 'wire',       45000.00, 'USD', 'Tehran Trading Co',   'ACC-IR001',    'Bank Mellat',          'Iran',           'wire',   'Business payment',         'completed', 'TXN-3001'),
(14, '2024-01-11 10:00:00', 'wire',       38000.00, 'USD', 'Pyongyang Corp',      'ACC-NK001',    'Korea Trade Bank',     'North Korea',    'wire',   'Trade payment',            'completed', 'TXN-3002'),

-- Counterparty on watchlist
(8,  '2024-01-15 11:00:00', 'wire',       55000.00, 'USD', 'Shell Corp LLC',      'ACC-CI001',    'Cayman National Bank', 'Cayman Islands', 'wire',   'Investment',               'completed', 'TXN-3003'),
(11, '2024-01-16 14:00:00', 'wire',       62000.00, 'USD', 'Ali Hassan',          'ACC-IR002',    'Iran Bank',            'Iran',           'wire',   'Personal transfer',        'completed', 'TXN-3004'),

-- Fuzzy name match (Victor vs Viktor)
(22, '2024-01-20 10:00:00', 'wire',       120000.00,'USD', 'Offshore Partner',    'ACC-RU001',    'Russian Bank',         'Russia',         'wire',   'Business deal',            'completed', 'TXN-3005'),

-- -----------------------------------------------
-- CATEGORY 4: PEP - Viktor, Mohammed, Elena, Zhou
-- -----------------------------------------------
-- PEP large wire
(14, '2024-02-01 09:00:00', 'wire',       250000.00,'USD', 'Private Holdings',    'ACC-CH001',    'Swiss Private Bank',   'Switzerland',    'wire',   'Asset transfer',           'completed', 'TXN-4001'),
(16, '2024-02-02 10:00:00', 'wire',       180000.00,'USD', 'Royal Trust Fund',    'ACC-AE001',    'Abu Dhabi Bank',       'UAE',            'wire',   'Investment',               'completed', 'TXN-4002'),

-- PEP + high risk country
(13, '2024-02-05 11:00:00', 'wire',       95000.00, 'USD', 'Kyiv Partners',       'ACC-UA001',    'Ukraine Bank',         'Ukraine',        'wire',   'Business payment',         'completed', 'TXN-4003'),
(19, '2024-02-06 14:00:00', 'wire',       310000.00,'USD', 'Beijing State Corp',  'ACC-CN001',    'Bank of China',        'China',          'wire',   'Government contract',      'completed', 'TXN-4004'),

-- PEP cash deposits
(13, '2024-02-10 09:00:00', 'deposit',    15000.00, 'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-4005'),
(13, '2024-02-11 10:00:00', 'deposit',    18000.00, 'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-4006'),
(13, '2024-02-12 11:00:00', 'deposit',    22000.00, 'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-4007'),

-- -----------------------------------------------
-- CATEGORY 5: ACCOUNT BEHAVIOR
-- -----------------------------------------------
-- New account large transaction (Sandra Mitchell - account 20, opened Jan 10)
(20, '2024-01-18 10:00:00', 'wire',       75000.00, 'USD', 'Unknown Corp',        'ACC-PA001',    'Panama City Bank',     'Panama',         'wire',   'Investment',               'completed', 'TXN-5001'),

-- Pass-through account (Shell Corp - account 21)
(21, '2024-02-01 08:00:00', 'deposit',    300000.00,'USD', 'Funding Source',      'ACC-XX001',    'Unknown Bank',         'Seychelles',     'wire',   'Capital injection',        'completed', 'TXN-5002'),
(21, '2024-02-01 09:30:00', 'wire',       295000.00,'USD', 'Next Destination',    'ACC-XX002',    'Panama Bank',          'Panama',         'wire',   'Onward transfer',          'completed', 'TXN-5003'),

-- Frozen account attempt (Ali Hassan - account 23)
(23, '2024-02-08 10:00:00', 'withdrawal', 5000.00,  'USD', 'Cash Withdrawal',     NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'failed',    'TXN-5004'),
(23, '2024-02-09 11:00:00', 'transfer',   3000.00,  'USD', 'Transfer Attempt',    'ACC-ZZ001',    'Local Bank',           'USA',            'online', 'Transfer',                 'failed',    'TXN-5005'),

-- Savings account doing wire (mismatched - account 2 Maria Gonzalez)
(2,  '2024-02-10 14:00:00', 'wire',       45000.00, 'USD', 'Foreign Business',    'ACC-MX001',    'Mexico Bank',          'Mexico',         'wire',   'Business payment',         'completed', 'TXN-5006'),

-- -----------------------------------------------
-- CATEGORY 6: GEOGRAPHIC / CROSS-BORDER
-- -----------------------------------------------
-- Multiple country wires in 7 days (Chen Wei - account 8)
(8,  '2024-02-12 09:00:00', 'wire',       30000.00, 'USD', 'Dubai Partner',       'ACC-AE002',    'Emirates Bank',        'UAE',            'wire',   'Trade payment',            'completed', 'TXN-6001'),
(8,  '2024-02-13 10:00:00', 'wire',       28000.00, 'USD', 'Singapore Corp',      'ACC-SG001',    'DBS Bank',             'Singapore',      'wire',   'Trade payment',            'completed', 'TXN-6002'),
(8,  '2024-02-14 11:00:00', 'wire',       35000.00, 'USD', 'Panama Holding',      'ACC-PA002',    'Panama Bank',          'Panama',         'wire',   'Investment',               'completed', 'TXN-6003'),
(8,  '2024-02-15 14:00:00', 'wire',       25000.00, 'USD', 'BVI Offshore',        'ACC-BV001',    'BVI Bank',             'BVI',            'wire',   'Investment',               'completed', 'TXN-6004'),

-- Circular flow: Account 1 → Account 8 → Account 14 → Account 1
(1,  '2024-02-18 09:00:00', 'wire',       50000.00, 'USD', 'Chen Wei',            'ACC-CW001',    'SF Bank',              'USA',            'wire',   'Business loan',            'completed', 'TXN-6005'),
(8,  '2024-02-19 10:00:00', 'wire',       49000.00, 'USD', 'Zhou Corp',           'ACC-ZC001',    'LA Bank',              'USA',            'wire',   'Repayment',                'completed', 'TXN-6006'),
(19, '2024-02-20 11:00:00', 'wire',       48000.00, 'USD', 'Arjun Mehta',         'ACC-AM001',    'SJ Bank',              'USA',            'wire',   'Investment return',        'completed', 'TXN-6007'),
(1,  '2024-02-21 14:00:00', 'deposit',    47000.00, 'USD', 'Incoming Wire',       NULL,           NULL,                   'USA',            'wire',   'Wire receipt',             'completed', 'TXN-6008'),

-- Tax haven transactions
(21, '2024-02-22 09:00:00', 'wire',       85000.00, 'USD', 'Seychelles Trust',    'ACC-SE001',    'Seychelles Bank',      'Seychelles',     'wire',   'Trust transfer',           'completed', 'TXN-6009'),

-- -----------------------------------------------
-- CATEGORY 7: KYC GAPS
-- -----------------------------------------------
-- KYC pending but doing large transactions (Ana Pereira - account 6)
(6,  '2024-02-25 10:00:00', 'wire',       35000.00, 'USD', 'Brazil Trade Co',     'ACC-BR001',    'Banco do Brasil',      'Brazil',         'wire',   'Business payment',         'completed', 'TXN-7001'),
(6,  '2024-02-26 11:00:00', 'deposit',    25000.00, 'USD', 'Cash Deposit',        NULL,           NULL,                   'USA',            'branch', 'Cash deposit',             'completed', 'TXN-7002'),

-- KYC failed doing transactions (Ibrahim Okonkwo - account 20)
(20, '2024-02-28 09:00:00', 'wire',       18000.00, 'USD', 'Lagos Partner',       'ACC-NG001',    'Nigerian Bank',        'Nigeria',        'wire',   'Business payment',         'completed', 'TXN-7003'),

-- High risk customer sudden spike (Carlos Mendoza - account 10)
(10, '2024-03-01 10:00:00', 'deposit',    45000.00, 'USD', 'Wire Receipt',        NULL,           NULL,                   'Colombia',       'wire',   'Wire receipt',             'completed', 'TXN-7004'),
(10, '2024-03-02 11:00:00', 'deposit',    52000.00, 'USD', 'Wire Receipt',        NULL,           NULL,                   'Colombia',       'wire',   'Wire receipt',             'completed', 'TXN-7005'),
(10, '2024-03-03 14:00:00', 'deposit',    38000.00, 'USD', 'Wire Receipt',        NULL,           NULL,                   'Colombia',       'wire',   'Wire receipt',             'completed', 'TXN-7006'),

-- -----------------------------------------------
-- CATEGORY 8: TRANSACTION PATTERNS
-- -----------------------------------------------
-- Fan-out: Account 16 (Mohammed) sending to many accounts
(16, '2024-03-05 09:00:00', 'wire',       5000.00,  'USD', 'Recipient 1',         'ACC-R001',     'Bank A',               'USA',            'wire',   'Payment',                  'completed', 'TXN-8001'),
(16, '2024-03-05 09:15:00', 'wire',       5000.00,  'USD', 'Recipient 2',         'ACC-R002',     'Bank B',               'USA',            'wire',   'Payment',                  'completed', 'TXN-8002'),
(16, '2024-03-05 09:30:00', 'wire',       5000.00,  'USD', 'Recipient 3',         'ACC-R003',     'Bank C',               'USA',            'wire',   'Payment',                  'completed', 'TXN-8003'),
(16, '2024-03-05 09:45:00', 'wire',       5000.00,  'USD', 'Recipient 4',         'ACC-R004',     'Bank D',               'Mexico',         'wire',   'Payment',                  'completed', 'TXN-8004'),
(16, '2024-03-05 10:00:00', 'wire',       5000.00,  'USD', 'Recipient 5',         'ACC-R005',     'Bank E',               'Panama',         'wire',   'Payment',                  'completed', 'TXN-8005'),
(16, '2024-03-05 10:15:00', 'wire',       5000.00,  'USD', 'Recipient 6',         'ACC-R006',     'Bank F',               'Brazil',         'wire',   'Payment',                  'completed', 'TXN-8006'),
(16, '2024-03-05 10:30:00', 'wire',       5000.00,  'USD', 'Recipient 7',         'ACC-R007',     'Bank G',               'UAE',            'wire',   'Payment',                  'completed', 'TXN-8007'),
(16, '2024-03-05 10:45:00', 'wire',       5000.00,  'USD', 'Recipient 8',         'ACC-R008',     'Bank H',               'China',          'wire',   'Payment',                  'completed', 'TXN-8008'),

-- Fan-in: Many accounts sending to account 21 (Shell Corp)
(1,  '2024-03-08 09:00:00', 'wire',       8000.00,  'USD', 'Shell Corp LLC',      'ACC-SC001',    'NY Bank',              'USA',            'wire',   'Investment',               'completed', 'TXN-8009'),
(4,  '2024-03-08 09:30:00', 'wire',       7500.00,  'USD', 'Shell Corp LLC',      'ACC-SC001',    'NY Bank',              'USA',            'wire',   'Investment',               'completed', 'TXN-8010'),
(7,  '2024-03-08 10:00:00', 'wire',       9000.00,  'USD', 'Shell Corp LLC',      'ACC-SC001',    'NY Bank',              'USA',            'wire',   'Investment',               'completed', 'TXN-8011'),
(9,  '2024-03-08 10:30:00', 'wire',       6500.00,  'USD', 'Shell Corp LLC',      'ACC-SC001',    'NY Bank',              'USA',            'wire',   'Investment',               'completed', 'TXN-8012'),
(11, '2024-03-08 11:00:00', 'wire',       8500.00,  'USD', 'Shell Corp LLC',      'ACC-SC001',    'NY Bank',              'USA',            'wire',   'Investment',               'completed', 'TXN-8013'),

-- Transaction reversals (Ibrahim - account 20)
(20, '2024-03-10 09:00:00', 'wire',       10000.00, 'USD', 'Test Recipient 1',    'ACC-T001',     'Bank X',               'USA',            'wire',   'Test transfer',            'reversed',  'TXN-8014'),
(20, '2024-03-10 09:30:00', 'wire',       10000.00, 'USD', 'Test Recipient 2',    'ACC-T002',     'Bank Y',               'USA',            'wire',   'Test transfer',            'reversed',  'TXN-8015'),
(20, '2024-03-10 10:00:00', 'wire',       10000.00, 'USD', 'Test Recipient 3',    'ACC-T003',     'Bank Z',               'USA',            'wire',   'Test transfer',            'reversed',  'TXN-8016'),
(20, '2024-03-10 10:30:00', 'wire',       10000.00, 'USD', 'Test Recipient 4',    'ACC-T004',     'Bank W',               'Nigeria',        'wire',   'Test transfer',            'reversed',  'TXN-8017'),

-- After hours large transactions (Viktor - account 13)
(13, '2024-03-12 01:15:00', 'wire',       75000.00, 'USD', 'Midnight Corp',       'ACC-MC001',    'Offshore Bank',        'Cayman Islands', 'online', 'Urgent transfer',          'completed', 'TXN-8018'),
(13, '2024-03-13 02:30:00', 'wire',       68000.00, 'USD', 'Night Trading LLC',   'ACC-MC002',    'BVI Bank',             'BVI',            'online', 'Urgent transfer',          'completed', 'TXN-8019'),
(13, '2024-03-14 03:45:00', 'wire',       82000.00, 'USD', 'Dark Holdings',       'ACC-MC003',    'Panama Bank',          'Panama',         'online', 'Urgent transfer',          'completed', 'TXN-8020'),

-- Normal transactions (low risk customers - for comparison baseline)
(1,  '2024-01-03 10:00:00', 'deposit',    3000.00,  'USD', 'Salary - Tech Corp',  NULL,           NULL,                   'USA',            'online', 'Salary deposit',           'completed', 'TXN-9001'),
(2,  '2024-01-04 11:00:00', 'withdrawal', 500.00,   'USD', 'ATM Withdrawal',      NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'completed', 'TXN-9002'),
(3,  '2024-01-05 14:00:00', 'deposit',    4000.00,  'USD', 'Salary - School',     NULL,           NULL,                   'USA',            'online', 'Salary deposit',           'completed', 'TXN-9003'),
(4,  '2024-01-06 09:00:00', 'transfer',   1000.00,  'USD', 'Rent Payment',        'ACC-LL001',    'Local Bank',           'USA',            'online', 'Rent payment',             'completed', 'TXN-9004'),
(5,  '2024-01-07 15:00:00', 'withdrawal', 200.00,   'USD', 'ATM Withdrawal',      NULL,           NULL,                   'USA',            'ATM',    'Cash withdrawal',          'completed', 'TXN-9005');


-- =============================================
-- INSERT: ALERTS (10 sample records)
-- =============================================
INSERT INTO alerts (txn_id, account_id, customer_id, alert_type, alert_category, alert_date, risk_score, status, description) VALUES
(1,  13, 11, 'Single-day structuring detected',          'structuring', '2024-01-05 16:00:00', 85, 'open',         '3 deposits between $5K-$10K on same day'),
(4,  12, 10, 'Multi-day structuring detected',           'structuring', '2024-01-11 17:00:00', 78, 'under_review', '4 deposits just below $10K over 4 days'),
(21, 21, 16, 'Dormant account sudden large activity',    'velocity',    '2024-01-25 10:00:00', 90, 'open',         'Account dormant, now receiving $200K wire'),
(23, 14, 11, 'Wire to sanctioned country - Iran',        'sanctions',   '2024-01-10 10:00:00', 95, 'escalated',    'Wire sent to Iran - FATF blacklisted country'),
(35, 14, 11, 'PEP large international wire',             'pep',         '2024-02-01 10:00:00', 88, 'open',         'PEP customer wired $250K to Switzerland'),
(43, 21, 16, 'Pass-through account detected',            'account',     '2024-02-01 10:00:00', 92, 'open',         '98% of incoming funds immediately wired out'),
(53, 8,  7,  'Wires to 4 countries in 7 days',           'geographic',  '2024-02-15 15:00:00', 80, 'open',         'Account wired to UAE, Singapore, Panama, BVI'),
(61, 6,  6,  'KYC pending - large transaction',          'kyc',         '2024-02-25 11:00:00', 75, 'open',         'Customer KYC pending, wired $35K internationally'),
(69, 16, 12, 'Fan-out pattern - 8 recipients same day',  'pattern',     '2024-03-05 11:00:00', 87, 'open',         'Single account sent to 8 different recipients'),
(78, 13, 11, 'After-hours large wire transfers',         'pattern',     '2024-03-12 04:00:00', 83, 'open',         'Large wires between 1am-4am for 3 consecutive days');


-- =============================================
-- INSERT: CASE MANAGEMENT (5 sample records)
-- =============================================
INSERT INTO case_management (alert_id, analyst_id, analyst_name, opened_date, closed_date, outcome, sar_reference, notes) VALUES
(1,  101, 'Sarah Johnson',  '2024-01-06', NULL,         'pending',    NULL,         'Reviewing bank branch deposits for structuring pattern'),
(2,  102, 'Mike Chen',      '2024-01-12', '2024-01-20', 'SAR_filed',  'SAR-2024-001','Multi-day structuring confirmed. SAR filed with FinCEN'),
(4,  103, 'Lisa Patel',     '2024-01-11', NULL,         'escalated',  NULL,         'Wire to Iran - escalated to compliance officer'),
(5,  101, 'Sarah Johnson',  '2024-02-02', NULL,         'pending',    NULL,         'PEP large wire under review'),
(6,  104, 'David Brown',    '2024-02-02', '2024-02-15', 'SAR_filed',  'SAR-2024-002','Pass-through confirmed. Shell Corp flagged. SAR filed');
