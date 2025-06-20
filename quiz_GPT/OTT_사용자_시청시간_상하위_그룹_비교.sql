-- chatGPT 출제
-- 사용자별 2024년 총 시청 시간을 기준으로 전체 유저의 상위 20%와 하위 20%를 구분하라.

WITH total_watch_time AS 
(
SELECT
	u.user_id,
	SUM(wl.watch_time) AS sum_watch_time
FROM
	users u
	LEFT JOIN watch_logs wl ON u.user_id = wl.user_id AND YEAR(wl.watch_date) = 2024
GROUP BY
	u.user_id
), percent AS
(
SELECT
	u.user_id,
	PERCENT_RANK() OVER(ORDER BY sum_watch_time DESC) AS percent_watch_time
FROM
	total_watch_time
), segment AS
(
SELECT
	u.user_id,
	CASE 
		WHEN percent_watch_time <= 0.2 THEN 'Heavy'
		WHEN percent_watch_time >= 0.8 THEN 'Light'
		ELSE 'Mid'
	END AS user_segment
FROM
	percent
)

SELECT user_segment, COUNT(DISTINCT user_id) AS user_count
FROM segment