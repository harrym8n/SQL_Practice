# 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성
# 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력
# 결과는 식품 가격을 기준으로 내림차순 정렬

SELECT t1.CATEGORY, t2.MAX_PRICE, t1.PRODUCT_NAME
FROM FOOD_PRODUCT t1, (SELECT CATEGORY, MAX(PRICE) as MAX_PRICE
                       FROM FOOD_PRODUCT
                       WHERE CATEGORY IN ('과자','국','김치','식용유')
                       GROUP BY CATEGORY
                       ORDER BY PRICE DESC) t2
WHERE t1.PRICE = t2.MAX_PRICE AND t1.CATEGORY = t2.CATEGORY
ORDER BY PRICE DESC


