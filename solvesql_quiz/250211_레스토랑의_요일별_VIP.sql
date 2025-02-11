SELECT t1.*
FROM
  tips t1,
  (SELECT
    day, MAX(total_bill) as MAX_bill
  FROM
    tips
  GROUP BY
    day) t2
WHERE
  t1.day = t2.day AND
  t1.total_bill = t2.MAX_bill