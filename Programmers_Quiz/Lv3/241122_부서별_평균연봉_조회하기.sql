# 부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회
# 평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL
# 결과는 부서별 평균 연봉을 기준으로 내림차순 정렬

SELECT hd.DEPT_ID, hd.DEPT_NAME_EN, ROUND(AVG(he.SAL),0) as AVG_SAL
FROM HR_DEPARTMENT hd, HR_EMPLOYEES he
WHERE hd.DEPT_ID = he.DEPT_ID
GROUP BY hd.DEPT_ID
ORDER BY AVG_SAL DESC