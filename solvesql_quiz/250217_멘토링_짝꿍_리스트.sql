SELECT
  t1.employee_id AS mentee_id,
  t1.name AS mentee_name,
  t2.employee_id AS mentor_id,
  t2.name AS mentor_name
FROM
  (SELECT employee_id, name, department
  FROM employees
  WHERE join_date BETWEEN '2021-10-01' AND '2021-12-31') t1,
  (SELECT employee_id, name, department
  FROM employees
  WHERE join_date < '2020-01-01') t2
WHERE
  t1.department != t2.department
ORDER BY
  mentee_id, mentor_id