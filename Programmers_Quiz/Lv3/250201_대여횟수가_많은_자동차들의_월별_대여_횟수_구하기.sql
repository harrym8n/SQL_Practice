# 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력
# 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬
# 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.

    
SELECT
    MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
FROM 
    CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE
    START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
GROUP BY
    MONTH(START_DATE), CAR_ID
HAVING
    CAR_ID IN (SELECT CAR_ID
                FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
                GROUP BY CAR_ID
                HAVING COUNT(*) >= 5)
ORDER BY
    MONTH, CAR_ID DESC