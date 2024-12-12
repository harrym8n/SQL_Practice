# 사원별 성과금 정보를 조회
# 사번, 성명, 평가 등급, 성과금을 조회
# 평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS
# 결과는 사번 기준으로 오름차순 정렬

SELECT t1.EMP_NO, t1.EMP_NAME, t2.GRADE, 
       CASE WHEN t2.GRADE = 'S' THEN t1.SAL*0.2
            WHEN t2.GRADE = 'A' THEN t1.SAL*0.15
            WHEN t2.GRADE = 'B' THEN t1.SAL*0.1
            WHEN t2.GRADE = 'C' THEN 0
        END as BONUS        
FROM HR_EMPLOYEES t1,
       (SELECT EMP_NO,
        AVG(SCORE) as SCORE,
        CASE WHEN AVG(SCORE) >= 96 THEN 'S'
             WHEN AVG(SCORE) >= 90 THEN 'A'
             WHEN AVG(SCORE) >= 80 THEN 'B'
             ELSE 'C'
        END as GRADE
        FROM HR_GRADE
        GROUP BY EMP_NO) t2
WHERE t1.EMP_NO = t2.EMP_NO
ORDER BY t1.EMP_NO