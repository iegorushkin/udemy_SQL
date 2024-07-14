/* CASE (= if / esle statement) */
-- General CASE syntax
SELECT 
	customer_id,
	CASE 
		WHEN customer_id < 100 THEN 'Premium'
		WHEN customer_id  BETWEEN 100 AND 200 THEN 'Plus'
		ELSE 'Normal'
	END AS customer_status
FROM customer;
-- So-called CASE expression 
-- (checks equality of data in a column to something)
SELECT 
	customer_id,
	CASE customer_id
		WHEN 2 THEN 'Winner'
		WHEN 5 THEN 'Second place'
		ELSE 'Losers'
	END as raffle_results
FROM customer;
--
SELECT 
	sum(test) as number_of_cheaps
FROM 
	(SELECT 
		CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END as test,
		rental_rate
	FROM film);
--
SELECT 
	sum(
	CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END) as cheaps,
	sum(
	CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
	END) as regular,
	sum(
	CASE rental_rate
		WHEN 4.99 THEN 1
		ELSE 0
	END) as premium
FROM film;

/* CASE challenge
Calculate the various amounts of films per age rating */
-- What ratings are there?
SELECT DISTINCT rating
FROM film;
-- CASE expression for the win
SELECT
	SUM(CASE rating 
				WHEN 'PG' THEN 1
				ELSE 0
			END) as n_PG,
	SUM(CASE rating 
				WHEN 'G' THEN 1
				ELSE 0
			END) as n_G,
	SUM(CASE rating 
				WHEN 'NC-17' THEN 1
				ELSE 0
			END) as n_NC17,
	SUM(CASE rating 
				WHEN 'PG-13' THEN 1
				ELSE 0
			END) as n_PG13,
	SUM(CASE rating 
				WHEN 'R' THEN 1
				ELSE 0
			END) as n_R
FROM film;

/* COALESCE finds 1st NOT null value from a list */	

/* CAST - convert one datatype into another */
SELECT
	CAST('5' AS INTEGER),
	typeof(CAST('5' AS INTEGER));
	
SELECT
	inventory_id,
	length(CAST (inventory_id AS TEXT)) AS char_length
FROM rental;

/* nullif */ 
CREATE TABLE departments(
	first_name TEXT,
	department TEXT
);

INSERT INTO departments (first_name, department)
VALUES
	('Vinton', 'A'),
	('Lauren', 'A'),
	('Claire', 'B');

SELECT
	(SUM (CASE WHEN department='A' THEN 1 ELSE 0 END) / 
	 SUM (CASE WHEN department='B' THEN 1 ELSE 0 END)
	) AS department_ratio	
FROM departments;

DELETE FROM departments
WHERE department = 'B';

SELECT
	(SUM (CASE WHEN department='A' THEN 1 ELSE 0 END) / 
	 nullif(SUM (CASE WHEN department='B' THEN 1 ELSE 0 END), 0)
	) AS department_ratio	
FROM departments;

/* Views */
CREATE VIEW customer_info AS 
	SELECT 
		left.first_name,
		left.last_name,
		right.address
	FROM customer AS left
	LEFT JOIN address AS right
	ON left.address_id=right.address_id;	
--
SELECT *
FROM customer_info;

/* Modify a view
SQLite does not have a CREATE OR REPLACE VIEW statement 
like PostgreSQL. 
However, you can achieve similar functionality by first checking
 if the view exists and then dropping it before creating the new view. */
-- (PostgreSQL)
 CREATE OR REPLACE VIEW customer_info AS
	SELECT 
		left.first_name,
		left.last_name,
		right.address,
		right.district
	FROM customer AS left
	LEFT JOIN address AS right
	ON left.address_id=right.address_id;	
-- Step 1: Drop the view if it exists
DROP VIEW IF EXISTS customer_info;
-- Step 2: Create the new view
CREATE VIEW customer_info AS
	SELECT 
		left.first_name,
		left.last_name,
		right.address,
		right.district
	FROM customer AS left
	LEFT JOIN address AS right
	ON left.address_id=right.address_id;	
-- Step 3: Display the results
SELECT *
FROM customer_info;

/* Rename table or view (PostGre) */
ALTER TABLE c_info RENAME TO film;







