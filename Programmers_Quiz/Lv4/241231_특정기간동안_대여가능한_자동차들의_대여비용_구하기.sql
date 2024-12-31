-- 자동차 종류가 '세단' 또는 'SUV' 인 자동차 중 
-- 2022년 11월 1일부터 2022년 11월 30일까지 대여 가능하고 
-- 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차에 대해서 
-- 자동차 ID, 자동차 종류, 대여 금액(컬럼명: FEE) 리스트를 출력
-- 정렬 순서 : 대여 금액 내림차순, 자동차 종류 오름차순, 자동차 ID 내림차순

SELECT
 DISTINCT t1.CAR_ID,
 t1.CAR_TYPE,
 ROUND((t1.DAILY_FEE*(1- t3.DISCOUNT_RATE/100)*30),0) as FEE
FROM
 CAR_RENTAL_COMPANY_CAR t1,
 CAR_RENTAL_COMPANY_DISCOUNT_PLAN t3
WHERE 
 t1.CAR_TYPE = t3.CAR_TYPE AND
 t1.CAR_ID NOT IN (SELECT CAR_ID 
                   FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 
                   WHERE END_DATE >= '2022-11-01' 
                   AND  START_DATE <= '2022-11-30') AND
 t1.CAR_TYPE in ('세단', 'SUV') AND
 t3.DURATION_TYPE = '30일 이상' AND
 (t1.DAILY_FEE*30 * (1- t3.DISCOUNT_RATE/100)) >= 500000 AND 
 (t1.DAILY_FEE*30 * (1- t3.DISCOUNT_RATE/100)) < 2000000
ORDER BY 
 FEE DESC,
 t1.CAR_TYPE ASC,
 t1.CAR_ID DESC