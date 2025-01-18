-- The total score of a hacker = sum of their maximum scores for all of the challenges
-- print the hacker_id, name, and total score of the hackers 
-- ordered by the descending score, ascending hacker_id
-- Exclude all hackers with a total score of 0

SELECT
    t1.hacker_id,
    t1.name,
    SUM(t2.score) as score

FROM
    Hackers t1,
    (
    SELECT
        t2.hacker_id,
        t2.challenge_id,
        MAX(t2.score) as score
    FROM 
        Hackers t1,
        Submissions t2
    WHERE
        t1.hacker_id = t2.hacker_id
    GROUP BY
        t2.hacker_id, t2.challenge_id
    ) t2
    
WHERE
    t1.hacker_id = t2.hacker_id
GROUP BY
    t1.hacker_id, t1.name
HAVING
    SUM(t2.score) != 0
ORDER BY
    score DESC,
    t1.hacker_id ASC