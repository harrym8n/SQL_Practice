# 컬럼명 모두 마스킹처리

WITH daily_users AS (
  SELECT 
    DATE(date) AS date,
    COUNT(DISTINCT user_id) AS dau
  FROM
    table # 마스킹처리
  WHERE
    user_id != '게스트' # 마스킹처리
  GROUP BY
    DATE(date)
),

wau_mau AS (
  SELECT 
    d.date,
    
    -- WAU: 해당 날짜 포함 이전 6일간
    (
      SELECT COUNT(DISTINCT e1.user_id)
      FROM table e1 # 마스킹처리
      WHERE DATE(e1.date) BETWEEN DATE_SUB(d.date, INTERVAL 6 DAY) AND d.date AND e1.user_id !='게스트' # 마스킹처리
    ) AS wau,
    
    -- MAU: 해당 날짜 포함 이전 30일간
    (
      SELECT COUNT(DISTINCT e2.user_id)
      FROM table e2 # 마스킹처리 
      WHERE DATE(e2.date) BETWEEN DATE_SUB(d.date, INTERVAL 30 DAY) AND d.date AND e2.user_id !='게스트' # 마스킹처리
    ) AS mau
  FROM daily_users d

)

SELECT 
  d.date AS day,
  d.dau AS DAU,
  w.wau AS WAU,
  w.mau AS MAU,
  ROUND((d.dau / NULLIF(w.wau, 0)) * 100, 2) AS stickiness_weekly,
  ROUND((d.dau / NULLIF(w.mau, 0)) * 100, 2) AS stickiness_monthly
FROM 
  daily_users d
JOIN 
  wau_mau w ON d.date = w.date
ORDER BY 
  day;