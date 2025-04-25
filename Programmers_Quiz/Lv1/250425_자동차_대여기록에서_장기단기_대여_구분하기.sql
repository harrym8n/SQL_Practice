-- 코드를 입력하세요
SELECT 
  HISTORY_ID, 
  CAR_ID,
  DATE_FORMAT(start_date,'%Y-%m-%d') as START_DATE,
  DATE_FORMAT(end_date,'%Y-%m-%d') as END_DATE, 
  if(DATEDIFF(END_DATE,START_DATE) >= 29, '장기 대여','단기 대여') as RENT_TYPE
FROM 
  CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE 
  start_date like '2022-09%'
ORDER BY
  history_id DESC