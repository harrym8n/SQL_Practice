SELECT
  t1.NAME
FROM
  CITY t1, COUNTRY t2
WHERE 
  t1.COUNTRYCODE = t2.CODE AND
  t2.CONTINENT = 'Africa'
