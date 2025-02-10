-- 요일별 매출액 합계를 구하고, 매출이 1500 달러 이상인 요일의 결제 내역을 모두 출력

SELECT
 *
FROM
  tips
WHERE
  day in (SELECT
            day
          FROM
            tips
          GROUP BY
            day
          HAVING
            SUM(total_bill) >= 1500)