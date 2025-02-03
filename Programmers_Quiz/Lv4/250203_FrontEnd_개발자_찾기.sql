-- Front End 스킬을 가진 개발자의 정보를 조회
-- ID를 기준으로 오름차순 정렬

SELECT 
    DISTINCT t1.ID, t1.EMAIL, t1.FIRST_NAME, t1.LAST_NAME
FROM
    DEVELOPERS t1,    
    (SELECT *
    FROM SKILLCODES
    WHERE CATEGORY = 'Front End') t2
WHERE
    t1.SKILL_CODE & t2.CODE = t2.CODE
ORDER BY
    t1.ID