/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT F.title
FROM film AS F
JOIN film_actor AS FA ON F.film_id = FA.film_id
WHERE FA.actor_id IN (
    SELECT FA2.actor_id
    FROM film_actor AS FA2
    JOIN film AS F2 ON FA2.film_id = F2.film_id
    WHERE F2.title = 'AMERICAN CIRCUS'
)
ORDER BY F.title ASC;

