SELECT
    t1.name
FROM
    city t1,
    country t2
WHERE
    t1.COUNTRYCODE = t2.CODE AND
    t2.CONTINENT = 'Africa'