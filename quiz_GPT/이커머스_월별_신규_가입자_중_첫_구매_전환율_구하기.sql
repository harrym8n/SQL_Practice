-- chatGPT 출제

WITH base AS
(
SELECT
	u.user_id,
	DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_month
FROM
	users u
	LEFT JOIN orders o ON u.user_id = o.user_id
WHERE
	o.status = 'completed'
GROUP BY
	u.user_id
HAVING
	DATE_FORMAT(u.signup_date, '%Y-%m') = DATE_FORMAT(MIN(o.order_date), '%Y-%m')
), converted_user_cnt AS
(
SELECT signup_month, COUNT(*) AS converted_users
FROM base
GROUP BY signup_month
ORDER BY signup_month
), signup_user_cnt AS
(
SELECT DATE_FORMAT(signup_date, '%Y-%m') AS signup_month, COUNT(DISTINCT user_id) AS signup_users
FROM users
GROUP BY signup_month
ORDER BY signup_month
)

SELECT
	suc.signup_month,
	suc.signup_users,
	cuc.converted_users,
	ROUND((cuc.converted_users/suc.signup_users)*100, 2) AS 'conversion_rate (%)'
FROM
	signup_user_cnt suc
	LEFT JOIN converted_user_cnt cuc ON suc.signup_month = cuc.signup_month
ORDER BY
	suc.signup_month