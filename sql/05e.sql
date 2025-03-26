/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */

SELECT F2.title  
FROM film_category AS FC1  
JOIN film_category AS FC2 ON FC1.category_id = FC2.category_id  
JOIN film AS F1 ON FC1.film_id = F1.film_id  
JOIN film AS F2 ON FC2.film_id = F2.film_id  
WHERE F1.title = 'AMERICAN CIRCUS'  
GROUP BY F2.film_id, F2.title  
HAVING COUNT(DISTINCT FC1.category_id) >= 2   
ORDER BY F2.title;  

