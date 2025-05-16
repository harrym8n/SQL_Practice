# 모든 변수 마스킹 처리(유저ID, date등 마스킹된 컬림명)
WITH CTE AS (
  SELECT
    user_id ,
    MIN(DATE(date)) AS first_date
  FROM
    table # 마스킹 처리
  GROUP BY
    user_id
), CTE_2 AS (
SELECT
  t1.user_id, DATE(t1.date) AS new_date
FROM
  table # 마스킹 처리  t1,
  CTE t2
WHERE
  t1.user_id = t2.user_id AND
  DATE(t1.date) <= DATE_ADD(t2.first_date, INTERVAL 30 DAY)
ORDER BY
  t1.user_id
), CTE_3 AS
(
SELECT DISTINCT user_id, new_date
FROM CTE_2
),
ordered_visits AS (
  SELECT
    user_id,
    DATE(new_date) AS visit_date,
    LAG(DATE(new_date)) OVER (PARTITION BY user_id ORDER BY DATE(new_date)) AS prev_visit_date
  FROM
    CTE_3
),
intervals AS (
  SELECT
    user_id,
    DATE_DIFF(visit_date, prev_visit_date, DAY) AS visit_gap
  FROM
    ordered_visits
  WHERE
    prev_visit_date IS NOT NULL
)

SELECT
  user_id,
  ROUND(AVG(visit_gap),2) AS avg_visit_gap_days
FROM
  intervals
GROUP BY
  user_id
ORDER BY
  user_id