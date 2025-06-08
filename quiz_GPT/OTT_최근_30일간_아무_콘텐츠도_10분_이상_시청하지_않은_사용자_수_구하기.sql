-- GPT 출제
-- 풀이 1
WITH watch_time_over AS
(
SELECT user_id
FROM watch_logs
WHERE DATE_FORMAT(watch_date, '%Y-%m-%d') BETWEEN '2025-05-02' AND '2025-06-01'
GROUP BY user_id
HAVING SUM(watch_time) >= 10
)

SELECT COUNT(DISTINCT u.user_id) AS unactive_user_count
FROM users u
LEFT JOIN watch_time_over wto ON u.user_id = wto.user_id
WHERE wto.user_id IS NULL


-- 풀이 2
SELECT COUNT(DISTINCT user_id) AS unactive_user_count
FROM users 
WHERE user_id NOT IN (
	SELECT user_id
	FROM watch_logs
	WHERE DATE_FORMAT(watch_date, '%Y-%m-%d') BETWEEN '2025-05-02' AND '2025-06-01'
	GROUP BY user_id
	HAVING SUM(watch_time) >= 10)