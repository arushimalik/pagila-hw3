/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH recent_movies AS (
  SELECT DISTINCT ON (R.customer_id, I.film_id)
         R.customer_id,
         I.film_id,
         R.rental_date
  FROM rental R
  JOIN inventory I ON R.inventory_id = I.inventory_id
  ORDER BY R.customer_id, I.film_id, R.rental_date DESC
),
ranked_movies AS (
  SELECT RM.*,
         row_number() OVER (PARTITION BY RM.customer_id ORDER BY RM.rental_date DESC) AS rn
  FROM recent_movies RM
),
action_rentals AS (
  SELECT RM.customer_id,
         RM.film_id,
         RM.rental_date,
         CASE
           WHEN EXISTS (
             SELECT 1
             FROM film_category FC
             JOIN category C ON FC.category_id = C.category_id
             WHERE FC.film_id = RM.film_id
               AND C.name = 'Action'
           ) THEN 1
           ELSE 0
         END AS is_action
  FROM ranked_movies RM
  WHERE rn <= 5
),
customer_action AS (
  SELECT customer_id,
         SUM(is_action) AS action_count
  FROM action_rentals
  GROUP BY customer_id
)
SELECT C.customer_id, C.first_name, C.last_name
FROM customer C
JOIN customer_action CA ON C.customer_id = CA.customer_id
WHERE CA.action_count >= 4
ORDER BY C.customer_id;

