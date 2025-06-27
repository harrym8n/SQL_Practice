-- chatGPT

WITH quarter_table AS
(
SELECT CONCAT('Q',QUARTER(signup_Date)) AS signup_quarter, COUNT(DISTINCT user_id) AS total_users
FROM users
GROUP BY QUARTER(signup_Date)
), pre_merge AS
(
SELECT
	CONCAT('Q',QUARTER(u.signup_Date)) AS signup_quarter, 
	CONCAT('Q',QUARTER(t.transaction_date)) AS active_quarter,
	COUNT(DISTINCT t.user_id) AS retained_users
FROM
	users u
	LEFT JOIN transactions t ON u.user_id = t.user_id
WHERE
	DATE_FORMAT(u.signup_date, '%Y-%m') IN ('2024-01','2024-02','2024-03')
GROUP BY
	QUARTER(u.signup_Date), QUARTER(t.transaction_date)
)

SELECT
	pm.signup_quarter,
	pm.active_quarter,
	pm.retained_users,
	qt.total_users,
	ROUND((pm.retained_users / qt.total_users)*100,2) AS retention_rate
FROM
	pre_merge pm
	INNER JOIN quarter_table qt ON pm.signup_quarter = qt.signup_quarter