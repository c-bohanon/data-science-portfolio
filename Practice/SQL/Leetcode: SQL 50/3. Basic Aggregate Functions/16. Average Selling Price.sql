/*
Table: Prices

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.

 

Table: UnitsSold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold. 

 

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
*/

WITH cte AS (
    SELECT 
        p.product_id,
        p.price,
        u.purchase_date,
        u.units
    FROM Prices p
    FULL OUTER JOIN UnitsSold u
        ON p.product_id = u.product_id
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
)
SELECT 
    product_id,
    CASE
        WHEN product_id IN (
            SELECT product_id
            FROM UnitsSold
        )
        THEN ROUND((SUM(price * units)::NUMERIC / SUM(units)::NUMERIC), 2)
        ELSE 0
        END AS average_price
FROM cte
GROUP BY product_id;
