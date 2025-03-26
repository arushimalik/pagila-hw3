/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT
    C.name,
    best_films.title,
    best_films.total_rentals AS "total rentals"
FROM category C
CROSS JOIN LATERAL (
    SELECT
        F.title,
        COUNT(R.rental_id) AS total_rentals
    FROM film_category FC
    JOIN film F ON FC.film_id = F.film_id
    JOIN inventory I ON F.film_id = I.film_id
    JOIN rental R ON I.inventory_id = R.inventory_id
    WHERE FC.category_id = C.category_id
    GROUP BY F.title
    ORDER BY COUNT(R.rental_id) DESC, F.title DESC
    LIMIT 5
) best_films
ORDER BY C.name, best_films.total_rentals DESC, best_films.title;

