WITH CTE AS (
    SELECT Task_ID, Start_Date, End_Date
    FROM Projects
    WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)
    ORDER BY Start_Date
    ), 
CTE_2 AS (
    SELECT
        t1.Task_ID, t1.Start_Date, t1.End_Date, t2.Start_Date AS Start_Date_2, t2.End_Date AS End_Date_2
    FROM 
        Projects t1 LEFT OUTER JOIN CTE t2
        ON t1.task_ID = t2.task_ID

    ),
CTE_3 AS (
    SELECT
        Task_ID,
        RANK() OVER(ORDER BY Start_Date) AS rnk,
        CASE
            WHEN Task_ID = 1 THEN Start_Date
            WHEN Task_ID !=1 AND (LAG(End_Date_2, 1) OVER (ORDER BY Start_Date)) IS NOT NULL THEN Start_Date
        END as new_Start_Date,
        CASE
            WHEN End_Date_2 IS NOT NULL THEN End_Date_2 
        END AS new_End_Date
    FROM
      CTE_2
), 
CTE_4 AS (
SELECT
    new_Start_Date AS Start_Date,
    CASE 
        WHEN new_End_Date IS NULL THEN LEAD(new_End_Date, 1) OVER (ORDER BY rnk)
        ELSE new_End_Date
    End AS End_Date
FROM
    CTE_3
WHERE
    new_Start_Date IS NOT NULL OR new_End_Date IS NOT NULL
)

SELECT *
FROM CTE_4
WHERE Start_Date IS NOT NULL
ORDER BY TIMESTAMPDIFF(DAY, DATE(End_Date), DATE(Start_Date)) DESC, Start_Date