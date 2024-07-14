SELECT
	first_name,
	last_name,
	email
FROM 
	customer;
	
SELECT 
	DISTINCT release_year
FROM 
	film;
	
SELECT 
	count (DISTINCT rating)
FROM 
	film;
	
SELECT *
FROM customer
WHERE first_name = 'JARED';

SELECT
	first_name,
	last_name,
	email
FROM
	customer
WHERE 
	first_name = 'NANCY' AND last_name = 'THOMAS';

SELECT
	title,
	description,
	release_year
FROM 
	film
WHERE title = 'OUTLAW HANKY';

SELECT
	address,
	district,
	postal_code,
	phone
FROM 
	address
WHERE 
	address = '259 Ipoh Drive';
--
SELECT
	create_date, 
	customer_id,
	first_name,
	last_name
FROM 
	customer
ORDER BY
	create_date ASC
LIMIT 10;

SELECT
	customer_id,
	payment_date
FROM 
	payment
ORDER BY
	payment_date ASC
LIMIT 10;
-- Совместим предыдущие два запроса
SELECT
	a.customer_id,
	a.first_name,
	a.last_name,
	b.payment_date
FROM
	customer as a
LEFT JOIN
	payment as b 
ON
	a.customer_id = b.customer_id
ORDER BY 
	b.payment_date ASC
LIMIT 10
--
SELECT 
	count(title) as number_of_movies
FROM 
	film
WHERE 
	length <= 50
--
SELECT *
FROM customer
WHERE first_name LIKE 'j%';

-- Задания раздела
-- How many payment transactions were greater than $5?
