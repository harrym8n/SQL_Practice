-- chatGPT 출제

WITH base AS
(
SELECT
	user_id,
	MAX(CASE WHEN event_type = 'app_open' THEN 1 ELSE 0 END) AS first_step,
	MAX(CASE WHEN event_type = 'send_money_try' THEN 1 ELSE 0 END) AS second_step,
	MAX(CASE WHEN event_type = 'send_money_complete' THEN 1 ELSE 0 END) AS third_step
FROM
	event_logs
GROUP BY
	user_id
), first_total AS
(
SELECT COUNT(DISTINCT user_id) AS cnt FROM base WHERE first_step=1
), second_total AS
(
SELECT COUNT(DISTINCT user_id) AS cnt FROM base WHERE first_step=1 AND second_step=1
)


SELECT
	'app_open' AS step,
	COUNT(DISTINCT user_id) AS user_count,
	ROUND(100.0,2) AS conversion_rate
FROM base
WHERE first_step = 1

UNION ALL

SELECT
	'send_money_try' AS step,
	COUNT(DISTINCT user_id) AS user_count,
	ROUND((COUNT(DISTINCT user_id)* 1.0/(SELECT cnt FROM first_total))*100,2) AS conversion_rate
FROM base
WHERE first_step = 1 AND second_step = 1

UNION ALL

SELECT
	'send_money_complete' AS step,
	COUNT(DISTINCT user_id) AS user_count,
	ROUND((COUNT(DISTINCT user_id)* 1.0/(SELECT cnt FROM second_total))*100,2) AS conversion_rate
FROM base
WHERE first_step = 1 AND second_step = 1 AND third_step = 1




