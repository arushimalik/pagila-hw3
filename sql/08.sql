/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */

SELECT F.title
FROM film F
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
WHERE R.customer_id IN (
    SELECT DISTINCT R2.customer_id
    FROM rental R2
    JOIN inventory I2 ON R2.inventory_id = I2.inventory_id
    JOIN film F2 ON I2.film_id = F2.film_id
    WHERE F2.title = 'BUCKET BROTHERHOOD'
)
AND F.title != 'BUCKET BROTHERHOOD'
GROUP BY F.title
HAVING COUNT(DISTINCT R.customer_id) >= 3;

