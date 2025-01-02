-- Query the two cities in STATION with the shortest and longest CITY names

SELECT CITY, CHAR_LENGTH(CITY)
FROM STATION
WHERE 
    CITY =
    (SELECT CITY
     FROM STATION
     ORDER BY CHAR_LENGTH(CITY) DESC, CITY  LIMIT 1) OR
    CITY =
    (SELECT CITY
     FROM STATION
     ORDER BY CHAR_LENGTH(CITY),CITY LIMIT 1)
ORDER BY CHAR_LENGTH(CITY)