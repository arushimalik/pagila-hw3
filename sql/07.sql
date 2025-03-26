/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT CONCAT(A.first_name, ' ', A.last_name) AS "Actor Name"
FROM film_actor AS FA
JOIN film_actor AS FA1 ON FA.film_id = FA1.film_id
JOIN actor AS A ON FA.actor_id = A.actor_id
WHERE FA1.actor_id IN (
    SELECT FA2.actor_id
    FROM film_actor AS FA2
    JOIN actor AS A2 ON FA2.actor_id = A2.actor_id
    WHERE FA2.film_id IN (
        SELECT FA3.film_id
        FROM film_actor AS FA3
        WHERE FA3.actor_id = (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
    )
) AND FA.actor_id != (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
AND FA.actor_id NOT IN (
    SELECT FA4.actor_id
    FROM film_actor AS FA4
    WHERE FA4.film_id IN (
        SELECT FA5.film_id
        FROM film_actor AS FA5
        WHERE FA5.actor_id = (SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL')
    )
)
ORDER BY "Actor Name";

