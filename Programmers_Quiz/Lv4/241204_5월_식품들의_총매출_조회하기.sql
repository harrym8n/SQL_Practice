# 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회
# 결과는 총매출을 기준으로 내림차순 정렬 / 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬

SELECT t1.PRODUCT_ID, t1.PRODUCT_NAME , (t1.PRICE*t2.AMOUNT) as TOTAL_SALES
FROM FOOD_PRODUCT t1, (SELECT PRODUCT_ID, SUM(AMOUNT) as AMOUNT
                       FROM FOOD_ORDER
                       WHERE PRODUCE_DATE LIKE '2022-05%'
                       GROUP BY PRODUCT_ID) t2
WHERE t1.PRODUCT_ID = t2.PRODUCT_ID
ORDER BY TOTAL_SALES DESC, t1.PRODUCT_ID ASC