# 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력
# 자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬

SELECT DISTINCT cc.CAR_ID
FROM CAR_RENTAL_COMPANY_CAR cc, CAR_RENTAL_COMPANY_RENTAL_HISTORY ch
WHERE cc.CAR_ID = ch.CAR_ID AND
      cc.CAR_TYPE = '세단' AND
      ch.START_DATE LIKE '2022-10%'
ORDER BY cc.CAR_ID DESC