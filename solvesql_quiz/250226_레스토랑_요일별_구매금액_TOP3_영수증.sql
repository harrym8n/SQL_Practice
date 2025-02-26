-- 월별 TOP3 영수증 출력
SELECT
  t1.day,
  t1.time,
  t1.sex,
  t1.total_bill
FROM
  (SELECT
    DENSE_RANK() OVER (PARTITION BY day ORDER BY total_bill DESC) as rnk,
    day,time,sex,total_bill
  FROM tips) t1
WHERE
  t1.rnk in (1,2,3)