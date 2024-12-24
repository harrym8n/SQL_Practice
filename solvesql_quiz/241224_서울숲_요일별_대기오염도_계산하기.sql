-- 요일별 평균 대기오염도 지표 조회 
-- 월요일부터 출력되도록 정렬
-- 대기오염도 지표는 소수점 넷째자리까지 표현

SELECT 
  CASE WHEN strftime('%u', measured_at) = '1' THEN '월요일'
       WHEN strftime('%u', measured_at) = '2' THEN '화요일'
       WHEN strftime('%u', measured_at) = '3' THEN '수요일'
       WHEN strftime('%u', measured_at) = '4' THEN '목요일'
       WHEN strftime('%u', measured_at) = '5' THEN '금요일'
       WHEN strftime('%u', measured_at) = '6' THEN '토요일'
       WHEN strftime('%u', measured_at) = '7' THEN '일요일'
                                END as weekday,
  ROUND(AVG(no2),4) as no2,
  ROUND(AVG(o3),4) as o3,
  ROUND(AVG(co),4) as co,
  ROUND(AVG(so2),4) as so2,
  ROUND(AVG(pm10),4) as pm10,
  ROUND(AVG(pm2_5),4) as pm2_5
FROM measurements
GROUP BY strftime('%u', measured_at)
ORDER BY strftime('%u', measured_at)