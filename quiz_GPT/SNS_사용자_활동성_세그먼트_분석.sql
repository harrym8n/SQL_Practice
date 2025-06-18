-- chatGPT 출제

WITH user_post_count AS (
  SELECT
    u.user_id,
    u.username,
    COUNT(p.post_id) AS total_posts
  FROM
    users u
    LEFT JOIN posts p 
      ON u.user_id = p.user_id AND YEAR(p.post_date) = 2024
  GROUP BY
    u.user_id, u.username
)

SELECT
  CASE
    WHEN total_posts >= 10 THEN 'Heavy User'
    WHEN total_posts >= 1 THEN 'Light User'
    ELSE 'Inactive'
  END AS user_segment,
  COUNT(DISTINCT user_id) AS user_count
FROM
  user_post_count
GROUP BY
  user_segment