# 리텐션 계산 및 코호트 분석(테이블 및 주요 변수 마스킹 처리)
WITH origin AS
  (
    SELECT user_id, min(DATE(date)) as origin_date
    FROM table # 마스킹 처리
    WHERE user_id != 'guest' AND
          date < `threshold` # 마스킹 처리
    GROUP BY user_id
  )
,base AS 
  (
  SELECT
    og.user_id,
    og.origin_date AS cohort_date,
    db.date AS event_date,
    TIMESTAMP_DIFF(DATE(db.date), og.origin_date, DAY) AS day_num
  FROM
    origin og,
    table db # 마스킹 처리
  WHERE
    og.user_id = db.user_id AND
    db.user_id != 'guest' AND
    db.date < `threshold` # 마스킹 처리
  ),
retention AS 
  (
    SELECT
      cohort_date,
      day_num,
      COUNT(DISTINCT user_id) AS retained_users
    FROM
      base
    WHERE
      day_num BETWEEN 0 AND 30
    GROUP BY
      cohort_date, day_num
  ),
cohort_size AS 
  (
    SELECT
      cohort_date,
      COUNT(DISTINCT user_id) AS fistday_users
    FROM
      base
    WHERE
      day_num = 0
    GROUP BY
      cohort_date
  )


SELECT
  r.cohort_date,
  r.day_num,
  cs.fistday_users,
  r.retained_users,
  ROUND((r.retained_users/cs.fistday_users)*100,2) AS retention_rate
FROM
  retention r,
  cohort_size cs
WHERE
  r.cohort_date = cs.cohort_date
ORDER BY
  r.cohort_date, r.day_num