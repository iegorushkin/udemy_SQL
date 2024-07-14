/* 
JOIN challenges
1. What are the emails of the customers who live in California?
*/
SELECT 
	customer_id,
	first_name,
	last_name,
	email, 
	address,
	district
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'California'
/* 
2. Get a list of all the movies the actor 'Nick Wahlberg' has been in.
*/
SELECT
	first_name,
	last_name,
	title
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LEFT JOIN film
ON film_actor.film_id = film.film_id
WHERE lower(first_name) = 'nick' AND lower(last_name) = 'wahlberg'
