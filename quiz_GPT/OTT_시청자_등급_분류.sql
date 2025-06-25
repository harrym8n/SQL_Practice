-- chatGPT
-- OTT 서비스는 시청자의 행동 데이터를 바탕으로 시청자 등급을 분류
-- 각 등급별로 5월에 시청을 시작한 사람들 중 6월에도 시청을 유지한 사람의 비율을 측정

WITH target AS
(
SELECT
	user_id
FROM
	watch_logs
GROUP BY
	user_id
HAVING
	DATE_FORMAT(MIN(watch_date), '%Y-%m') = '2024-05'
), may_log AS
(
SELECT
	user_id,
	SUM(watch_time) AS total_watch_time
FROM
	watch_logs
WHERE
	DATE_FORMAT(watch_date, '%Y-%m') = '2024-05'
GROUP BY
	user_id
), segment_table AS
(
SELECT
	t.user_id,
	CASE 
		WHEN ml.total_watch_time >= 600 THEN 'Heavy'
		WHEN ml.total_watch_time >= 300 THEN 'Medium'
		WHEN ml.total_watch_time >= 1 THEN 'Light'
	END AS segment
FROM
	target t
	LEFT JOIN may_log ml ON t.user_id = ml.user_id	
), june_log AS
(
SELECT
	user_id
FROM
	watch_logs
WHERE
	DATE_FORMAT(watch_date, '%Y-%m') = '2024-06'
GROUP BY
	user_id
), retention_check AS
(
SELECT
	st.user_id,
	st.segment,
	CASE 
		WHEN jl.user_id IS NULL THEN '이탈'
		ELSE '유지'
	END AS retention_mark
FROM
	segment_table st
	LEFT JOIN june_log jl ON st.user_id = jl.user_id
)

SELECT 
	segment,
	COUNT(DISTINCT user_id) AS total_users,
	COUNT(DISTINCT CASE WHEN retention_mark = '유지' THEN user_id END) AS retained_users,
	ROUND((COUNT(DISTINCT CASE WHEN retention_mark = '유지' THEN user_id END)/
		COUNT(DISTINCT user_id))*100, 2) AS retention_rate
FROM
	retention_check
GROUP BY
	segment