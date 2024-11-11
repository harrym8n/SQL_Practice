# 2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회
# 2022년도의 평가 점수는 상,하반기 점수의 합을 의미
# 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.

SELECT SUM(gd.SCORE) as SCORE, emp.EMP_NO, emp.EMP_NAME, emp.POSITION, emp.EMAIL
FROM HR_DEPARTMENT d, HR_EMPLOYEES emp, HR_GRADE gd
WHERE d.DEPT_ID = emp.DEPT_ID and
      emp.EMP_NO = gd.EMP_NO and gd.YEAR = 2022
GROUP BY emp.EMP_NO
ORDER BY SCORE DESC LIMIT 1