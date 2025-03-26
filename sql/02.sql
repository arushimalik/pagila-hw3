/*
 * Compute the country with the most customers in it. 
 */

SELECT CO.country  
FROM Customer AS C  
JOIN Address AS A ON C.address_id = A.address_id  
JOIN City AS CI ON A.city_id = CI.city_id  
JOIN Country AS CO ON CI.country_id = CO.country_id  
GROUP BY CO.country  
ORDER BY COUNT(*) DESC  
LIMIT 1;

