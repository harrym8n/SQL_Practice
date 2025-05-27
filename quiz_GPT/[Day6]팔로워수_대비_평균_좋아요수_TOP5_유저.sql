-- GPT출제
-- 팔로워 수 대비 평균 좋아요 수 TOP 5 유저
-- users, follows, posts, likes 테이블을 이용
-- 자신의 게시물에 받은 전체 좋아요 수를 해당 유저의 팔로워 수로 나눈 ‘팔로워당 평균 좋아요 수’가 높은 유저 TOP 5를 출력
-- 팔로워 수가 1명 이상인 유저만 포함하고, 평균 좋아요 수는 소수점 둘째 자리까지 반올림하시오.

WITH total_likes AS
(
	SELECT
		p.user_id,
		COUNT(DISTINCT l.like_id) AS total_like_cnt
	FROM 
		posts p
		LEFT JOIN likes l ON p.post_id = l.post_id
	GROUP BY
		p.user_id

), total_follower AS
(
	SELECT
		u.user_id,
		COUNT(DISTINCT f.follower_id) AS total_follower_cnt
	FROM
		users u
		LEFT JOIN follows f ON u.user_id = f.followee_id
	GROUP BY
		u.user_id
	HAVING
		COUNT(DISTINCT f.follower_id) >=1
)

SELECT
	u.user_id,
	u.username,
	ROUND((tl.total_like_cnt / tf.total_follower_cnt),2) AS like_per_follower
FROM
	users u
	JOIN total_likes tl ON u.user_id = tl.user_id
	JOIN total_follower tf ON u.user_id = tf.user_id
ORDER BY
	like_per_follower DESC LIMIT 5