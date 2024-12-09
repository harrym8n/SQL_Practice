# 년, 월, 성별 별로 상품을 구매한 회원수를 집계
# 결과는 년, 월, 성별을 기준으로 오름차순 정렬 / 성별 정보가 없는 경우 결과에서 제외
SELECT YEAR(t2.sales_date) as YEAR, MONTH(t2.sales_date) as MONTH, t1.GENDER, COUNT(DISTINCT t2.USER_ID) as USERS
FROM USER_INFO t1, ONLINE_SALE t2
WHERE t1.USER_ID = t2.USER_ID AND
      t1.GENDER is NOT NULL
GROUP BY YEAR(t2.sales_date), MONTH(t2.sales_date), t1.GENDER
ORDER BY YEAR, MONTH, t1.GENDER, USERS