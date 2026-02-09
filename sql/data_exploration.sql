/* =====================================================
   Task 1: Table Inventory & Grain Checks
   Purpose: Understand table size, grain, and key integrity
   ===================================================== */

--Table: accounts.sql

--1. Total row count
--Expectation: One account per row returned
SELECT COUNT(*) AS total_accounts FROM ChurnAnalyticsDB.accounts;
--Result: 500

--2. Finding the primary key 
--Expectation: account_id uniquely identifies each account
SELECT COUNT(DISTINCT account_id)  AS total_distinct_accounts FROM ChurnAnalyticsDB.accounts;
--Result: 500 
--account_id has 500 distinct instances, which is equal to the total number of rows.

--3. Check for NULL values in the primary key
--Expectation: No NULL account_id values
SELECT COUNT(*) AS total_nulls_in_account_id FROM ChurnAnalyticsDB.accounts WHERE account_id IS NULL;
--Result: 0 rows. There are no rows with any null values in account_id.


--Table: churn_events.sql

--1. Total row count
--Expectation: One account per churn event
SELECT COUNT(*)  AS total_churn_events FROM ChurnAnalyticsDB.churn_events;
--Result: 600 

--2. Finding the primary key 
--Expectation: churn_event_id uniquely identifies each event
SELECT COUNT(DISTINCT churn_event_id)  AS total_distinct_events FROM ChurnAnalyticsDB.churn_events;
--Result: 600 
--churn_event_id has 600 distinct instances, which is equal to the total number of rows.

--3. Check for NULL values in the primary key
--Expectation: No NULL churn_event_id values
SELECT COUNT(*) AS total_nulls_in_event_id FROM ChurnAnalyticsDB.churn_events WHERE churn_event_id IS NULL;
--Result: 0 rows. There are no rows with any null values in churn_event_id.

--4. Check whether accounts have multiple churn events.
--Expectation: Accounts may have more than one churn event
SELECT account_id, COUNT(churn_event_id) as total_churn_events
FROM ChurnAnalyticsDB.churn_events 
GROUP BY account_id 
HAVING count(*) > 1
ORDER BY total_churn_events DESC;
--Result: Almost a third of the accounts have more than one churn event


--Table: feature_usage.sql

--1. Total row count
SELECT COUNT(*) AS total_feature_usage FROM ChurnAnalyticsDB.feature_usage;
--Result: 25000 rows 

--2. Checking for primary key distinction
SELECT COUNT(DISTINCT usage_id)  AS distinct_usage_id FROM ChurnAnalyticsDB.feature_usage;
--Result: 24979 rows; 21 or fewer rows might have been duplicated

--3. Check for NULL values in the primary key
SELECT COUNT(*) AS total_null_usage_id FROM ChurnAnalyticsDB.feature_usage where usage_id IS NULL;
--Result: 0

--4. Check whether subscriptions have multiple usage records
SELECT subscription_id, COUNT(usage_id)  AS usage_per_subscription 
FROM ChurnAnalyticsDB.feature_usage 
GROUP BY subscription_id 
HAVING count(*) > 1 
ORDER BY usage_per_subscription DESC;
--Result: Multiple subscriptions are being used more than once.


--Table: subscriptions.sql

--1. Total row count
--Expectation: each row represents a subscription
SELECT COUNT(*) AS total_subscriptions FROM ChurnAnalyticsDB.subscriptions;
--Result: 5000 rows

--2. Finding the primary key
--Expectation: subscription_id uniquely identifies each account
SELECT COUNT(DISTINCT subscription_id) as distinct_subscription_ids FROM ChurnAnalyticsDB.subscriptions;
--Result: 5000 rows

--3. Check for NULL values in the primary key
SELECT COUNT(*) as total_null_subscriptionid FROM ChurnAnalyticsDB.subscriptions where subscription_id IS NULL;
--Result: 0

--4. Check for accounts with multiple subscriptions
SELECT account_id, COUNT(subscription_id) AS subscription_per_account 
FROM ChurnAnalyticsDB.subscriptions 
GROUP BY account_id 
HAVING COUNT(*) > 1 
ORDER BY subscription_per_account DESC;
--Result: Multiple accounts have more than one subscription.


--Table: support_tickets.sql

--1. Total row count
--Expectation: each row represents a support ticket
SELECT COUNT(*) AS total_tickets FROM ChurnAnalyticsDB.support_tickets;
--Result: 2000

--2. Check for primary key
--Expectation: ticket_id uniquely identifies each account
SELECT COUNT(DISTINCT ticket_id) AS distinct_ticket_ids FROM ChurnAnalyticsDB.support_tickets;
--Result: 2000

--3. Check for NULL values in the primary key
SELECT COUNT(*) AS null_ticket_ids FROM ChurnAnalyticsDB.support_tickets WHERE ticket_id IS NULL;
--Result: 0

--4. Check for multiple support tickets for the accounts 
SELECT account_id, count(ticket_id) as tickets_per_account 
FROM ChurnAnalyticsDB.support_tickets 
GROUP BY account_id 
HAVING count(*) > 1 
ORDER BY tickets_per_account DESC;
--Result: Multiple accounts have more than one support ticket
