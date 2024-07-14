/* 
1. During which months did the payments occur?
Preferably, format the aswer to return back the full month name.
*/
SELECT 
	DISTINCT(
		CASE month_number
			WHEN '01' THEN 'January'
			WHEN '02' THEN 'February'
			WHEN '03' THEN 'March'
			WHEN '04' THEN 'April'
			WHEN '05' THEN 'May'
			WHEN '06' THEN 'June'
			WHEN '07' THEN 'July'
			WHEN '08' THEN 'August'
			WHEN '09' THEN 'September'
			WHEN '10' THEN 'October'
			WHEN '11' THEN 'November'
			WHEN '12' THEN 'December'
		END) AS month_name
FROM 
	(SELECT 
		payment_date,
		strftime('%m', payment_date) AS month_number
	FROM payment);

-- Let's try to make it simplier
SELECT 
	DISTINCT(
		CASE strftime('%m', payment_date)
			WHEN '01' THEN 'January'
			WHEN '02' THEN 'February'
			WHEN '03' THEN 'March'
			WHEN '04' THEN 'April'
			WHEN '05' THEN 'May'
			WHEN '06' THEN 'June'
			WHEN '07' THEN 'July'
			WHEN '08' THEN 'August'
			WHEN '09' THEN 'September'
			WHEN '10' THEN 'October'
			WHEN '11' THEN 'November'
			WHEN '12' THEN 'December'
		END
	) AS month_name
FROM payment;
/* 
2. How many payments occured on a Monday?
*/
SELECT count(*) as monday_payments
FROM
	(SELECT
		payment_date,
		strftime('%w', payment_date) as weekday
	FROM payment
	WHERE weekday = '1'
);

/* String functionality */
-- length:
SELECT 
	length(first_name),
	first_name
FROM customer;
-- concat:
SELECT 
	lower(first_name || '_' || last_name) as name
FROM customer;
-- more complicated concat
SELECT 
	lower(first_name || last_name || '@gmail.com') as email
FROM customer;
--
SELECT  lower(
	substr(first_name, 1, 1) || '_' || last_name || '@gmail.com'
	) as email
FROM customer;
/* Subqueries */
--
SELECT 
	film_id,
	title,
	rental_rate
FROM film
WHERE rental_rate > (SELECT avg(rental_rate) FROM film);
-- 1. Find film_ids of movies that were rented in specified dates.
SELECT
	inventory.inventory_id,
	inventory.film_id,
	rental.return_date
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
ORDER BY inventory.inventory_id ASC;
-- 2. What are the titles of films that were rented?
SELECT film_id, title
FROM film
WHERE film_id in (
	SELECT inventory.film_id
	FROM rental
	INNER JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
);
-- Example of using EXISTS
/* 
The EXISTS operator in SQL is used to test for the existence of any
records in a subquery. It returns TRUE if the subquery returns one
or more records, and FALSE if the subquery returns no records. 
The EXISTS operator is often used in WHERE clauses to restrict
the rows returned by the main query based on the results 
of a subquery.

How EXISTS Works
Subquery Execution: The subquery is executed for each row of 
the main query.
Existence Check: If the subquery returns any rows, the EXISTS
condition evaluates to TRUE for that row of the main query.
If the subquery returns no rows, the EXISTS condition evaluates
to FALSE.
*/
-- Find customers who have at least one payment
-- whose amount is greater than 11.
SELECT
	customer.customer_id,
	customer.first_name,
	customer.last_name
FROM customer
WHERE EXISTS (
	SELECT *
	FROM payment
	WHERE customer.customer_id = payment.customer_id
	AND payment.amount > 11
);
/* 
Self JOIN
Find all the pairs of films that have the same length.
*/
SELECT
	f1.length,
	f1.title,
	f2.title
FROM film as f1
INNER JOIN film as f2 
ON f1.film_id != f2.film_id AND f1.length = f2.length
ORDER BY f1.length ASC;
-- Can compare datetime with string
SELECT return_date
FROM rental
WHERE return_date < '2005-09-01'



