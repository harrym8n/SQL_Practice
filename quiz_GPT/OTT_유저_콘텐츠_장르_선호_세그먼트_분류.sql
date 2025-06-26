-- chatGPT
-- 유저 콘텐츠 장르 선호 세그먼트 분류

WITH watch_count AS
(
SELECT
	u.user_id,
	COALESCE(c.genre,'Unknown') AS genre,
	COUNT(DISTINCT c.content_id) AS watch_cnt
FROM
	users u
	LEFT JOIN watch_logs wl ON wl.user_id = u.user_id
	LEFT JOIN contents c ON wl.content_id = c.content_id
WHERE
	YEAR(wl.watch_date) = 2024
GROUP BY
	u.user_id, genre
), rank AS
(
SELECT
	genre,
	user_id,
	watch_cnt,
	DENSE_RANK() OVER(PARTITION BY user_id ORDER BY watch_cnt DESC) AS rank_col
FROM
	watch_count
)

SELECT 
	genre,
	COUNT(DISTINCT user_id) AS user_count,
	ROUND((COUNT(DISTINCT user_id) / (SELECT COUNT(DISTINCT user_id) FROM users))*100, 2) AS 'preference_ratio (%)'
FROM rank
WHERE rank_col = 1
GROUP BY genre