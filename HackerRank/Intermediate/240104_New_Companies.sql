-- print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees
-- Order output by ascending company_code
 
SELECT
  t1.company_code, t1.founder, t2.lead_manager, t3.senior_manager, t4.manager, t5.employee
FROM
  Company t1,
  (SELECT company_code, COUNT(DISTINCT lead_manager_code) as lead_manager FROM Lead_Manager GROUP BY company_code) t2,
  (SELECT company_code, COUNT(DISTINCT senior_manager_code) as senior_manager FROM Senior_Manager GROUP BY company_code) t3,
  (SELECT company_code, COUNT(DISTINCT manager_code) as manager FROM Manager GROUP BY company_code) t4,
  (SELECT company_code, COUNT(DISTINCT employee_code) as employee FROM Employee GROUP BY company_code) t5
WHERE 
  t1.company_code = t2.company_code AND
  t2.company_code = t3.company_code AND
  t3.company_code = t4.company_code AND
  t4.company_code = t5.company_code
ORDER BY
  t1.company_code