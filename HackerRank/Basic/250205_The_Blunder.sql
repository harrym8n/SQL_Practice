SELECT CEIL(AVG(Salary)- AVG(replace(Salary,0,'')))
FROM EMPLOYEES
