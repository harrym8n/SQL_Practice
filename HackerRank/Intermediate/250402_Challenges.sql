WITH CTE AS (
    SELECT t2.hacker_id, t2.name, t1.cnt
    FROM 
        (SELECT hacker_id, COUNT(challenge_id) as cnt 
        FROM Challenges 
        GROUP BY hacker_id) t1,
        Hackers t2
    WHERE t1.hacker_id = t2.hacker_id
)

SELECT *
FROM CTE
WHERE 
    cnt = (SELECT max(cnt) FROM CTE) OR
    cnt in (SELECT cnt
            FROM CTE
            GROUP BY cnt
            HAVING COUNT(hacker_id) = 1)
ORDER BY cnt DESC, hacker_id