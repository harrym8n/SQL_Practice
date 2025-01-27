SELECT
    CASE WHEN (A+B <= C) OR (B+C <= A) OR (A+C <= B) THEN 'Not A Triangle'
        ELSE
            CASE WHEN A=B AND B=C THEN 'Equilateral'
                 WHEN (A=B AND B!=C) OR (B=C AND A!=B) OR (A=C AND A!=B) THEN 'Isosceles'
                 WHEN A!=B AND B!=C AND A!=C THEN 'Scalene'
            END
    END
FROM TRIANGLES
