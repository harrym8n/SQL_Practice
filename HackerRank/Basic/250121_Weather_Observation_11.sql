SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[a,e,i,o,u]' OR
    CITY NOT REGEXP '[a,e,i,o,u]$'