/*
 * Compute the number of customers who live outside of the US.
 *
 * NOTE:
 * It is possible to solve this problem with the "cheesy" query
 * ```
 * SELECT 563 AS count;
 * ```
 * Although this type of query will pass the test case for your homework,
 * it will not score you any points on your midterm/final exams.
 * I therefore strongly recommend that you solve this query "properly".
 *
 * Your goal should be to have your queries remain correct even if the data in the database changes arbitrarily.
 */

SELECT count(*) AS count
FROM Customer AS C
JOIN Address AS A ON C.address_id = A.address_id
JOIN City AS CI ON A.city_id = CI.city_id
JOIN Country AS CO ON CI.country_id = CO.country_id
WHERE CO.country_id <> 103;
