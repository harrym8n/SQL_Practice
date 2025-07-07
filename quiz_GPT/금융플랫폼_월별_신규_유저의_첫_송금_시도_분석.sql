-- chatGPT 출제

WITH base AS 
(
SELECT
	MIN(el.event_time) AS first_try_date,
	el.user_id
FROM
	event_logs el
	JOIN users u ON el.user_id=u.user_id
WHERE
	(u.signup_date BETWEEN '2025-04-01' AND '2025-06-30') AND
	el.event_type = 'send_money_try' AND
	u.signup_date < el.event_time
GROUP BY
	el.user_id
)

SELECT 
	FORMAT(first_try_date,'yyyy-MM') AS first_try_month, 
	COUNT(DISTINCT user_id) AS user_count
FROM base
GROUP BY FORMAT(first_try_date,'yyyy-MM')
ORDER BY FORMAT(first_try_date,'yyyy-MM')