/*
1. Return the customer IDs of customers who have spent at least $110
with the staff member who has an ID of 2.
The answer should be customers 187 and 148.
*/
SELECT
	staff_id,
	customer_id,
	sum(amount) as total_spending
FROM payment
WHERE staff_id = 2
GROUP BY staff_id, customer_id
HAVING total_spending > 110
ORDER BY total_spending ASC;
/*
2. How many films begin with the letter J?
The answer should be 20.
*/
SELECT count(*)
FROM film
WHERE title LIKE 'J%';
/*
3. What customer has the highest customer ID number whose name
starts with an 'E' and has an address ID lower than 500?
The answer is Eddie Tomlin
*/
SELECT 
	max(customer_id),
	first_name,
	last_name
FROM (
	SELECT 
		customer_id,
		first_name,
		last_name,
		address_id
	FROM customer
	WHERE first_name LIKE 'E%' AND address_id < 500);
