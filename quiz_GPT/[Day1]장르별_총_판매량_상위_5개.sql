-- GPT 출제
-- [문제 1] 장르별 총 판매량 상위 5개
-- games와 genres 테이블을 활용하여 장르별 전 세계 총 판매량(sales_na + sales_eu + sales_jp + sales_other)을 계산
-- 판매량이 높은 상위 5개 장르의 이름과 판매량을 출력하시오. (단, 판매량은 소수점 둘째 자리까지 반올림)

SELECT
  gn.name,
  (gm.sales_eu + gm.sales_jp + gm.sales_na + gm.sales_other) AS sum_global
FROM 
  games gm, genres gn
WHERE
  gm.genre_id = gn.genre_id
GROUP BY
  gm.genre_id