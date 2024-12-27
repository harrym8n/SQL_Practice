# 자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력
# 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬

WITH FEE_INFO AS 
(
SELECT 
 t2.HISTORY_ID, 
 t2.CAR_ID,
 t1.CAR_TYPE,
 (DATEDIFF(end_date,start_date)+1) as DATE,
 t1.DAILY_FEE,
 CASE WHEN  (DATEDIFF(end_date,start_date)+1)  >= 7 AND  (DATEDIFF(end_date,start_date)+1)  < 30 THEN '7일 이상'
      WHEN  (DATEDIFF(end_date,start_date)+1)  >= 30 AND  (DATEDIFF(end_date,start_date)+1)  < 90 THEN '30일 이상'
      WHEN  (DATEDIFF(end_date,start_date)+1)  >= 90 THEN '90일 이상'
      ELSE '7일 미만'
 END as 'DURATION_TYPE'
FROM 
 CAR_RENTAL_COMPANY_CAR t1,
 CAR_RENTAL_COMPANY_RENTAL_HISTORY t2
WHERE 
 t1.CAR_TYPE = '트럭' AND
 t1.CAR_ID = t2.CAR_ID 
)

SELECT 
 t1.HISTORY_ID,
 IFNULL(ROUND((t1.DAILY_FEE*((100-t2.DISCOUNT_RATE)/100)*t1.DATE),0),t1.DAILY_FEE*t1.DATE) as FEE
FROM 
 FEE_INFO t1
LEFT OUTER JOIN 
 CAR_RENTAL_COMPANY_DISCOUNT_PLAN t2
ON 
 t1.CAR_TYPE = t2.CAR_TYPE AND
 t1.DURATION_TYPE = t2.DURATION_TYPE 
ORDER BY 
 FEE DESC,
 HISTORY_ID DESC