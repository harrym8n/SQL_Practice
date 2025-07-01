-- chatGPT
-- 2024년 4월에 처음 게임을 시작한 유저들의 5월 리텐션율을 계산

SELECT
	DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_month,
	COUNT(DISTINCT u.user_id) AS total_users,
	COUNT(DISTINCT CASE WHEN gs.session_date LIKE '2024-05%' THEN gs.user_id END) AS retained_users,
	ROUND((COUNT(DISTINCT CASE WHEN gs.session_date LIKE '2024-05%' THEN gs.user_id END)/
		COUNT(DISTINCT u.user_id))*100,2) AS retention_rate
FROM
	users u
	LEFT JOIN game_sessions gs ON u.user_id=gs.user_id
WHERE
	u.signup_date LIKE '2024-04%'
GROUP BY
	signup_month