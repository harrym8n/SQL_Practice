-- 데이터베이스에 포함된 모든 사용자에 대해 각 사용자의 친구 수를 집계해 출력

WITH tmp_t AS (
  SELECT
    user_id,
    SUM(num_friends) as num_friends
  FROM
    (SELECT user_a_id as user_id, COUNT(DISTINCT user_b_id) as num_friends
    FROM edges
    GROUP BY user_a_id
    UNION ALL
    SELECT user_b_id as user_id, COUNT(DISTINCT user_a_id) as num_friends
    FROM edges
    GROUP BY user_b_id)
  GROUP BY 
    user_id
)

SELECT
  t1.user_id,
  CASE
    WHEN t2.num_friends IS NULL THEN 0
    ELSE t2.num_friends
  END as num_friends
FROM
  users t1
LEFT JOIN
  tmp_t t2 ON t1.user_id = t2.user_id
ORDER BY 
  t2.num_friends DESC, t1.user_id