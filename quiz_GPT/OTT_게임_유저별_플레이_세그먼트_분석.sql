-- chatGPT
-- 사용자별 총 플레이 횟수(세션 수)와 총 플레이 시간을 구하세요.

WITH CTE AS
(
SELECT
	u.user_id,
	CASE
		WHEN COUNT(DISTINCT gs.session_id) >= 20 OR SUM(COALESCE(gs.play_time, 0)) >= 1000 THEN 'Hardcore'
		WHEN COUNT(DISTINCT gs.session_id) >= 5 OR SUM(COALESCE(gs.play_time, 0)) >= 200 THEN 'Casual'
		ELSE 'Inactive'
	END AS player_segment
FROM
	users u
	LEFT JOIN game_sessions gs ON u.user_id = gs.user_id AND YEAR(gs.session_date) = 2024
GROUP BY
	u.user_id
)

SELECT player_segment, COUNT(DISTINCT user_id) AS user_count
FROM  CTE
GROUP BY player_segment