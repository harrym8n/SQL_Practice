# PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력
# 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬

SELECT p.PRODUCT_CODE as PRODUCT_CODE, SUM(p.PRICE*os.SALES_AMOUNT) as SALES
FROM PRODUCT p, OFFLINE_SALE os
WHERE p.PRODUCT_ID = os.PRODUCT_ID
GROUP BY p.PRODUCT_CODE
ORDER BY SALES desc, p.PRODUCT_CODE asc