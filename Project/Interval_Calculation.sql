WITH ordered_visits AS (
  SELECT
    user_id,
    DATE(date) AS visit_date,
    LAG(DATE(date)) OVER (PARTITION BY user_id ORDER BY DATE(date)) AS prev_visit_date
  FROM
    table # 데이터 마스킹 처리
),
intervals AS (
  SELECT
    visit_date,
    user_id,
    DATE_DIFF(visit_date, prev_visit_date, DAY) AS visit_gap
  FROM
    ordered_visits
), 
final_t AS (
SELECT
  visit_date,
  user_id
FROM
  intervals
GROUP BY
  user_id, visit_date
ORDER BY
  user_id, visit_date
), final_interval AS(
SELECT
  user_id,
  visit_date,
  LAG(DATE(visit_date)) OVER (PARTITION BY user_id ORDER BY DATE(visit_date)) AS prev_visit_date
FROM
  final_t
ORDER BY
  user_id, visit_date
)

SELECT
    user_id,
    visit_date,
    DATE_DIFF(visit_date, prev_visit_date, DAY) AS visit_gap
FROM final_interval
WHERE( user_id != '게스트') AND (visit_date BETWEEN 'A기간' AND 'B기간') # 데이터 마스킹 처리
ORDER BY  CAST(user_id AS INT64), visit_date