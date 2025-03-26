/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT DISTINCT first_name, last_name 
FROM actor AS A
JOIN film_actor FA ON A.actor_id = FA.actor_id
JOIN film F ON FA.film_id = F.film_id
JOIN film_category FC ON F.film_id = FC.film_id
JOIN category C ON FC.category_id = C.category_id
WHERE C.name = 'Children'
AND A.actor_id NOT IN (
    SELECT FA.actor_id
    FROM film_actor FA
    JOIN film F ON FA.film_id = F.film_id
    JOIN film_category FC ON F.film_id = FC.film_id
    JOIN category C ON FC.category_id = C.category_id
    WHERE C.name = 'Horror'
)
ORDER BY last_name ASC;
