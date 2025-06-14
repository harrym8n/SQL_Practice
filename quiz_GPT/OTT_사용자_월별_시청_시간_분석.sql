-- chatGPT 출제

-- 2024년 한 해 동안의 데이터를 기반으로, 가입일이 2024년 이전인 사용자들만 포함
-- 각 사용자별로 월별 총 시청 시간을 수동 피벗 형식으로 출력

SELECT
	wl.user_id,
	u.name,
	SUM(CASE WHEN MONTH(wl.watch_date) = 1 THEN wl.watch_time ELSE 0 END) AS jan_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 2 THEN wl.watch_time ELSE 0 END) AS feb_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 3 THEN wl.watch_time ELSE 0 END) AS mar_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 4 THEN wl.watch_time ELSE 0 END) AS apr_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 5 THEN wl.watch_time ELSE 0 END) AS may_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 6 THEN wl.watch_time ELSE 0 END) AS jun_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 7 THEN wl.watch_time ELSE 0 END) AS jul_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 8 THEN wl.watch_time ELSE 0 END) AS aug_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 9 THEN wl.watch_time ELSE 0 END) AS sep_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 10 THEN wl.watch_time ELSE 0 END) AS oct_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 11 THEN wl.watch_time ELSE 0 END) AS nov_watch_time,
	SUM(CASE WHEN MONTH(wl.watch_date) = 12 THEN wl.watch_time ELSE 0 END) AS dec_watch_time
FROM
	watch_logs wl
	JOIN users u ON wl.user_id = u.user_id
WHERE
	YEAR(wl.watch_date) = 2024 AND
	YEAR(u.signup_date) < 2024
GROUP BY
	wl.user_id,
	u.name
ORDER BY
	wl.user_id