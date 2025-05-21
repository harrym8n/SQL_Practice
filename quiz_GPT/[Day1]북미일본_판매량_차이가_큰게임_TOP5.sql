-- [문제 4] 북미-일본 판매량 차이가 큰 게임 TOP 5
-- games 테이블에서 북미(sales_na)와 일본(sales_jp) 판매량 차이의 절대값이 큰 게임 상위 5개를 구하시오.
-- 출력할 컬럼은 게임 이름, 북미 판매량, 일본 판매량, 판매량 차이(절대값, 소수 둘째 자리까지 반올림).

SELECT
  name,
  sales_na,
  sales_jp,
  ROUND(ABS(sales_na - sales_jp),2) AS diif_sales
FROM 
  games
ORDER BY
  diif_sales DESC LIMIT 5