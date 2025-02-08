-- 2021년 8월 2일부터 2021년 8월 9일까지 날짜별로 몇 명의 방문자가 방문했는지 
SELECT
  date(event_date_kst) as dt,
  COUNT(DISTINCT user_pseudo_id) as users
FROM
  ga
WHERE
  date(event_date_kst) BETWEEN '2021-08-02' AND '2021-08-09'
GROUP BY 
  date(event_date_kst)
ORDER BY
  dt