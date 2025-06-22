--chatGPT출제

WITH base_users AS (
  SELECT
    user_id
  FROM
    users
  WHERE
    signup_date < '2024-01-01'
),

posters AS (
  SELECT
    DISTINCT user_id
  FROM
    posts
  WHERE
    YEAR(post_date) = 2024
),

commenters AS (
  SELECT
    DISTINCT user_id
  FROM
    comments
  WHERE
    YEAR(comment_date) = 2024
),

engaged AS (
  SELECT
    p.user_id
  FROM
    posters p
    INNER JOIN commenters c ON p.user_id = c.user_id
)

SELECT 'Total Users' AS funnel_stage, COUNT(*) AS user_count
FROM base_users

UNION ALL

SELECT 'Active Posters', COUNT(DISTINCT bu.user_id)
FROM base_users bu
  INNER JOIN posters p ON bu.user_id = p.user_id

UNION ALL

SELECT 'Active Commenters', COUNT(DISTINCT bu.user_id)
FROM base_users bu
  INNER JOIN commenters c ON bu.user_id = c.user_id

UNION ALL

SELECT 'Engaged Users', COUNT(DISTINCT bu.user_id)
FROM base_users bu
  INNER JOIN engaged e ON bu.user_id = e.user_id