# 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회
# 결과는 장바구니의 아이디 순
SELECT t1.CART_ID
FROM (SELECT CART_ID, NAME
      FROM CART_PRODUCTS
      WHERE NAME IN ('Milk','Yogurt')
      GROUP BY CART_ID, NAME
      ORDER BY CART_ID) t1
GROUP BY t1.CART_ID
HAVING COUNT(*) >=2
ORDER BY t1.CART_ID