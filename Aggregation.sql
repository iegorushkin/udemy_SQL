--
SELECT ROUND(AVG(replacement_cost), 2)
FROM FILM;
-- Какой член команды совершил больше продаж?
SELECT 
	staff_id,
	count(amount) as n_deals
FROM payment
GROUP BY staff_id;
-- Средняя стоимость замены касеты в зависимости от рейтинга?
SELECT  
	rating,
	round(avg(replacement_cost), 4) as avg_rep_cost
FROM film
GROUP BY rating
ORDER BY avg_rep_cost DESC;
-- Найти топ-5 клиентов, которые потратили больше всего денег
SELECT
	customer_id,
	sum(amount) as total_spending
FROM payment
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;
-- Какие клиенты совершили не менее 40 успешных покупок?
SELECT 
	customer_id,
	count(amount) as N
FROM payment
GROUP BY customer_id 
HAVING N >= 40
ORDER BY N ASC;
-- Для члена команды №2, какие клиенты потратили более 100 долларов?
SELECT
	customer_id,
	sum(amount) as total_money
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING total_money > 100
ORDER BY total_money DESC;
