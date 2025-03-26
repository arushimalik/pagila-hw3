/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT
  CO.country,
  SUM(P.amount) AS total_payments
FROM PAYMENT P
JOIN CUSTOMER C ON P.customer_id = C.customer_id
JOIN ADDRESS A ON C.address_id = A.address_id
JOIN CITY CI ON A.city_id = CI.city_id
JOIN COUNTRY CO ON CI.country_id = CO.country_id
GROUP BY CO.country
ORDER BY total_payments DESC, CO.country ASC;

