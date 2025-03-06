-- 2017년 1월 1일 0시부터 2017년 2월 1일 0시까지
-- 10분 단위로 3개 발전소 전력 소비량의 1시간 범위 단순 이동 평균을 계산
-- 이동 평균 값은 소수점 셋째 자리에서 반올림

SELECT 
  DATETIME(measured_at, '+10 minutes') AS end_at,
  ROUND((AVG(zone_quads) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)),2) AS zone_quads,
  ROUND((AVG(zone_smir) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)),2) AS zone_smir,
  ROUND((AVG(zone_boussafou) OVER(ORDER BY measured_at ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)),2) AS zone_boussafou
FROM 
  power_consumptions
WHERE
  strftime('%Y-%m-%d %H', measured_at) BETWEEN '2017-01-01 00' AND '2017-01-31 23'