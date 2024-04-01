/*
Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.

 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.

 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
*/

SELECT
    r.contest_id,
    ROUND((CAST(COUNT(DISTINCT(r.user_id)) AS NUMERIC) /
        CAST(
            (SELECT COUNT(DISTINCT(user_id)) FROM Users) 
            AS NUMERIC) * 100), 2) AS percentage 
FROM Users u
JOIN Register r
    ON u.user_id = r.user_id
GROUP BY r.contest_id
ORDER BY 
    percentage DESC,
    r.contest_id;
