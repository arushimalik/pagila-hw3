/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

WITH best_film AS (
    SELECT film_id 
    FROM film
    WHERE title IN ('AMERICAN CIRCUS','ACADEMY DINOSAUR', 'AGENT TRUMAN')
)
SELECT F.title
FROM film F
JOIN film_actor FA ON F.film_id = FA.film_id
JOIN (
    SELECT actor_id, COUNT(*) AS counts
    FROM film_actor 
    WHERE film_id IN (SELECT film_id FROM best_film)
    GROUP BY actor_id
) actor_counts ON FA.actor_id = actor_counts.actor_id
GROUP BY F.title
HAVING SUM(actor_counts.counts) >= 3
ORDER BY F.title;

