-- find the node type of Binary Tree(Root, Leaf, Inner)
-- ordered by the value of the node

SELECT 
    N,
    CASE WHEN P IS NULL THEN 'Root'
         WHEN P IS NOT NULL AND
              N NOT IN (SELECT P AS N FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
         ELSE 'Inner'
    END AS NODE
FROM BST
ORDER BY N