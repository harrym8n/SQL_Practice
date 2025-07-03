-- chatGPT 출제

SELECT
	DATE_FORMAT(start_date,'%Y-%m') AS start_month,
	plan_type,
	COUNT(DISTINCT subscription_id) AS total_users,
	COUNT(DISTINCT CASE WHEN end_date IS NULL OR 
		DATE_FORMAT(start_date,'%Y-%m') != DATE_FORMAT(end_date,'%Y-%m') 
		THEN subscription_id END) AS retained_users,
	ROUND(
		COUNT(DISTINCT CASE WHEN end_date IS NULL OR 
			DATE_FORMAT(start_date,'%Y-%m') != DATE_FORMAT(end_date,'%Y-%m') 
			THEN subscription_id END)/
				COUNT(DISTINCT subscription_id)*100,2) AS 'retention_rate (%)'
FROM
	subscriptions
WHERE
	start_date BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY
	DATE_FORMAT(start_date, '%Y-%m'),
	plan_type
ORDER BY
	start_month, 
	plan_type