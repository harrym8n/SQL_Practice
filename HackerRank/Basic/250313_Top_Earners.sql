-- 직원들의 총 소득의 최고값과 그 소득에 해당하는 직원 수 조회

SELECT 
    ROUND(MAX(salary*months)),
    COUNT(*)
FROM
    Employee
WHERE
    salary*months = (SELECT MAX(salary*months) FROM Employee)