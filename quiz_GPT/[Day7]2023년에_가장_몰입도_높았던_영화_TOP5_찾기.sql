-- GPT 출제
-- 2023년에 시청된 영화들 중, 각 영화별 평균 시청률이 가장 높은 TOP 5 영화
-- 시청률은 (watch_time / duration) 으로 계산하며, 1을 초과하는 경우는 1로 처리함 (100% 초과 금지)
-- 영화 제목, 장르, 평균 시청률(소수점 둘째 자리까지) 출력

SELECT
	m.title,
	m.genre,
	ROUND(AVG(LEAST(wl.watch_time / m.duration, 1)), 2) AS watch_ratio
FROM
	movies m
	JOIN watch_logs wl ON m.movie_id = wl.movie_id
WHERE
	YEAR(wl.watch_date) = 2023
GROUP BY
	m.movie_id,
	m.title,
	m.genre
ORDER BY
	watch_ratio DESC LIMIT 5