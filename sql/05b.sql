/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT f.title
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN film_actor AS ac_fa ON ac_fa.actor_id = fa.actor_id 
JOIN film AS ac ON ac.film_id = ac_fa.film_id
WHERE ac.title = 'AMERICAN CIRCUS'  
GROUP BY f.title
HAVING COUNT(DISTINCT fa.actor_id) >= 2;  

