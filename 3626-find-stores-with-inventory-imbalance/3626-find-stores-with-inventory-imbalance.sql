# Write your MySQL query statement below
WITH cte1 AS (
    SELECT store_id,
           MAX(price) AS maxi,
           MIN(price) AS mini,
           COUNT(*) AS cnt
    FROM Inventory
    GROUP BY store_id
    HAVING COUNT(*) >= 3
),
cte2 AS (
    SELECT store_id,
           (
               SELECT product_name
               FROM Inventory i
               WHERE i.store_id = c.store_id
                 AND i.price = c.maxi
               LIMIT 1
           ) AS most_exp_product,
           (
               SELECT quantity
               FROM Inventory i
               WHERE i.store_id = c.store_id
                 AND i.price = c.maxi
               LIMIT 1
           ) AS max_quant,
           (
               SELECT product_name
               FROM Inventory i
               WHERE i.store_id = c.store_id
                 AND i.price = c.mini
               LIMIT 1
           ) AS cheapest_product,
           (
               SELECT quantity
               FROM Inventory i
               WHERE i.store_id = c.store_id
                 AND i.price = c.mini
               LIMIT 1
           ) AS min_quant
    FROM cte1 c
)

SELECT c.store_id,
       s.store_name,
       s.location,
       c.most_exp_product,
       c.cheapest_product,
       ROUND(c.min_quant / COALESCE(c.max_quant, 0), 2) AS imbalance_ratio
FROM cte2 c
LEFT JOIN Stores s
       ON c.store_id = s.store_id
WHERE c.max_quant < c.min_quant
ORDER BY imbalance_ratio DESC,
         store_name;