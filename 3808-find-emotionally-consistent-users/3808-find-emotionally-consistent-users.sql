# Write your MySQL query statement below
WITH rankings AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS count,
        RANK() OVER(PARTITION BY user_id ORDER BY COUNT(*) DESC) AS rn
    FROM reactions
    GROUP BY 1, 2
)
SELECT
    rc.user_id,
    ra.reaction AS dominant_reaction,
    ROUND(ra.count / rc.total_count, 2) AS reaction_ratio
FROM rankings ra
    JOIN (
        SELECT
            user_id,
            COUNT(*) AS total_count
        FROM reactions
        GROUP BY user_id
        HAVING COUNT(*) >= 5
    ) AS rc
    ON ra.user_id = rc.user_id
WHERE (rn = 1) AND (ra.count / rc.total_count >= 0.6)
GROUP BY 1, 2
ORDER BY 3 DESC, 1 