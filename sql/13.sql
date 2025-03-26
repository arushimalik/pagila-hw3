/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

WITH FILM_REVENUE AS (
  SELECT
    F.film_id,
    F.title,
    SUM(P.amount) AS revenue
  FROM FILM F
  JOIN INVENTORY I ON F.film_id = I.film_id
  JOIN RENTAL R ON I.inventory_id = R.inventory_id
  JOIN PAYMENT P ON R.rental_id = P.rental_id
  GROUP BY F.film_id, F.title
)
SELECT
  ACTOR_ID,
  FIRST_NAME,
  LAST_NAME,
  FILM_ID,
  TITLE,
  RNK AS "rank",
  REVENUE
FROM (
  SELECT
    A.actor_id,
    A.first_name,
    A.last_name,
    FR.film_id,
    FR.title,
    FR.revenue,
    RANK() OVER (PARTITION BY A.actor_id ORDER BY FR.revenue DESC, FR.film_id ASC) AS RNK
  FROM ACTOR A
  JOIN FILM_ACTOR FA ON A.actor_id = FA.actor_id
  JOIN FILM_REVENUE FR ON FA.film_id = FR.film_id
) SUB
WHERE RNK <= 3
ORDER BY ACTOR_ID, RNK;

