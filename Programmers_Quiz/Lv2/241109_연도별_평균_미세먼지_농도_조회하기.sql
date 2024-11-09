# 수원 지역의 연도 별 평균 미세먼지 오염도와 평균 초미세먼지 오염도를 조회
# 평균 미세먼지 오염도와 평균 초미세먼지 오염도의 컬럼명은 각각 PM10, PM2.5
# 값은 소수 셋째 자리에서 반올림
# 연도를 기준으로 오름차순 정렬

SELECT YEAR(YM) as YEAR, ROUND(AVG(PM_VAL1),2) as PM10, ROUND(AVG(PM_VAL2),2) as 'PM2.5'
FROM AIR_POLLUTION
WHERE LOCATION2 = '수원'
GROUP BY YEAR(YM)
ORDER BY YEAR(YM) asc