-- chatGPT 출제
-- 팔로워 수 5명 이상인 사용자들 중
-- 자신이 작성한 댓글 수를 팔로워 수로 나눈 ‘댓글 생성 비율’이 높은 사용자 TOP 5

WITH follower_table AS
(
SELECT
    u.user_id,
    u.username,
    COUNT(DISTINCT f.follower_id) AS follower_count
FROM
    users u
    JOIN follows f ON u.user_id = f.followee_id
GROUP BY
    u.user_id
HAVING
    COUNT(DISTINCT f.follower_id) >= 5
)

SELECT
    ft.username,
    ft.follower_count,
    COALESCE(COUNT(DISTINCT c.comment_id), 0) AS comment_count,
    ROUND(COALESCE(COUNT(DISTINCT c.comment_id), 0) / ft.follower_count, 2) AS comment_ratio
FROM
    follower_table ft
    LEFT JOIN comments c ON ft.user_id = c.user_id
GROUP BY
    ft.user_id, ft.username,ft.follower_count
ORDER BY
    comment_ratio DESC LIMIT 5