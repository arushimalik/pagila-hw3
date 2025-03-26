/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

WITH category_matches AS (
    SELECT F2.film_id, F2.title
    FROM film_category FC1
    JOIN film_category FC2 ON FC1.category_id = FC2.category_id
    JOIN film F1 ON FC1.film_id = F1.film_id
    JOIN film F2 ON FC2.film_id = F2.film_id
    WHERE F1.title = 'AMERICAN CIRCUS'
    GROUP BY F2.film_id, F2.title
    HAVING COUNT(DISTINCT FC1.category_id) >= 2
),
actor_matches AS (
    SELECT F2.film_id, F2.title
    FROM film_actor FA1
    JOIN film_actor FA2 ON FA1.actor_id = FA2.actor_id
    JOIN film F1 ON FA1.film_id = F1.film_id
    JOIN film F2 ON FA2.film_id = F2.film_id
    WHERE F1.title = 'AMERICAN CIRCUS'
    GROUP BY F2.film_id, F2.title
)
SELECT DISTINCT CM.title
FROM category_matches CM
JOIN actor_matches AM ON CM.film_id = AM.film_id
ORDER BY CM.title;

