/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */

SELECT
    C.first_name,
    C.last_name,
    R.title,
    R.rental_date
FROM
    customer C
JOIN LATERAL (
    SELECT F.title, R.rental_date
    FROM rental R
    JOIN inventory I ON R.inventory_id = I.inventory_id
    JOIN film F ON I.film_id = F.film_id
    WHERE R.customer_id = C.customer_id
    ORDER BY R.rental_date DESC
    LIMIT 1
) AS R ON true
ORDER BY C.last_name;
