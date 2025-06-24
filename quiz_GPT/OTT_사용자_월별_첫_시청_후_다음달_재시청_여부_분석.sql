-- chatGPT
-- 사용자 월별 첫 시청 후 다음달 재시청 여부 분석(리텐션)

WITH first_month AS 
(
SELECT
	user_id,
	MIN(DATE_FORMAT(watch_date, '%Y-%m')) AS first_watch_month
FROM
	watch_logs
WHERE
	YEAR(watch_date) = 2024
GROUP BY
	user_id
), user_watch_month AS
(
SELECT
	user_id,
	DATE_FORMAT(watch_date, '%Y-%m') AS month_watch
FROM
	watch_logs
WHERE
	YEAR(watch_date) = 2024
GROUP BY
	user_id, DATE_FORMAT(watch_date, '%Y-%m')
),joined AS 
(
SELECT
    fm.user_id,
    fm.first_watch_month,
    uwm.month_watch,
    DATE_FORMAT(
      DATE_ADD(CONCAT(fm.first_watch_month, '-01'), INTERVAL 1 MONTH),
      '%Y-%m'
    ) AS next_month
FROM
    first_month fm
    LEFT JOIN user_watch_month uwm ON fm.user_id = uwm.user_id
)

SELECT
	first_watch_month,
	COUNT(DISTINCT user_id) AS total_users,
	COUNT(DISTINCT CASE WHEN month_watch = next_month THEN user_id END) AS retained_users,
	ROUND(
	COUNT(DISTINCT CASE WHEN month_watch = next_month THEN user_id END) 
	 / COUNT(DISTINCT user_id) * 100, 2
	) AS retention_rate
FROM
	joined
GROUP BY
	first_watch_month
ORDER BY
	first_watch_month