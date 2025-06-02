-- 기준 연도: watch_date가 2024년에 해당하는 데이터만 분석
-- content.genre = '다큐멘터리'인 콘텐츠를 1번이라도 시청한 유저는 제외
-- 결과는 단일 숫자로 출력 (unwatched_user_count)

WITH target_year AS
(
	SELECT DISTINCT user_id
	FROM watch_log
	WHERE YEAR(watch_date) = 2024
),target_genre AS
(
	SELECT DISTINCT wl.user_id
	FROM watch_log wl
	JOIN content c ON wl.content_id = c.content_id
	WHERE YEAR(wl.watch_date) = 2024 AND
		c.genre = '다큐멘터리'
)

SELECT
	COUNT(*) AS unwatched_user_count
FROM
	target_year ty
	LEFT JOIN target_genre tg ON ty.user_id = tg.user_id
WHERE
	tg.user_id IS NULL