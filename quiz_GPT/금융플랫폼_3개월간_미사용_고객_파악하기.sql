-- chatGPT 출제
-- 3개월간 미사용 고객 파악하기

-- 풀이 1) LEFT JOIN + IS NULL 활용
WITH not_target_user AS
(
SELECT
	user_id
FROM
	event_logs
WHERE
	(event_time BETWEEN '2025-04-01' AND '2025-06-30') AND
	event_type = 'send_money_complete'
GROUP BY 
	user_id
)

SELECT
	COUNT(DISTINCT u.user_id) AS inactive_user_count
FROM
	users u
	LEFT JOIN not_target_user ntu ON u.user_id = ntu.user_id
WHERE
	u.signup_date < '2025-04-01' AND
	ntu.user_id IS NULL 



-- 풀이 2) NOT IN 활용
WITH not_target_user AS
(
SELECT
	user_id
FROM
	event_logs
WHERE
	(event_time BETWEEN '2025-04-01' AND '2025-06-30') AND
	event_type = 'send_money_complete'
GROUP BY 
	user_id
)

SELECT
	COUNT(DISTINCT user_id) AS inactive_user_count
FROM
	users
WHERE
	signup_date < '2025-04-01' AND
	user_id NOT IN (SELECT user_id FROM not_target_user)