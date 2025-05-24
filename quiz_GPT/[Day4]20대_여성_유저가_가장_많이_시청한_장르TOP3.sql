-- chatGPT 생성 문제
-- 20대 여성 유저가 가장 많이 시청한 장르 TOP 3
-- users, content, watch_history 테이블을 활용
-- 20대 여성(M/F = ‘F’) 유저가 가장 많이 시청한 장르를 시청 시간 기준으로 집계
-- 상위 3개의 장르를 출력

SELECT
	c.genre,	
	SUM(wh.watch_time) AS sum_watch_time
FROM
	users u
	JOIN watch_history wh ON u.user_id = wh.user_id
	JOIN content c ON c.content_id = wh.content_id
WHERE
	(u.gender = 'F') AND 
	(u.age BETWEEN 20 AND 29)
GROUP BY
	c.genre
ORDER BY
	sum_watch_time DESC LIMIT 3