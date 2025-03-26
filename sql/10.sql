/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

WITH customer_soending AS (
    SELECT
        C.customer_id,
        CONCAT(C.first_name, ' ', C.last_name) AS name,
        SUM(P.amount) AS total_payment
    FROM customer C
    JOIN payment P ON C.customer_id = P.customer_id
    GROUP BY C.customer_id
),
customers AS (
    SELECT *,
           NTILE(100) OVER (ORDER BY total_payment) AS percentile
    FROM customer_soending
)
SELECT customer_id, name, total_payment, percentile
FROM customers
WHERE percentile >= 90
ORDER BY name;

