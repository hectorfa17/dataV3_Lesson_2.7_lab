USE SAKILA;
#How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT fc.category_id as 'category_id', c.name as 'cat_name', count(fc.film_id) as 'film_count' FROM film_category as fc
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY category_id;	
 
#Display the total amount rung up by each staff member in August of 2005.

SELECT s.staff_id, s.first_name, s.last_name, sum(amount), month(payment_date) as 'Month'
FROM STAFF as s
JOIN payment  as p
ON s.staff_id = p.staff_id
WHERE payment_date LIKE '2005-08%'
GROUP BY s.staff_id, month(payment_date);

#Which actor has appeared in the most films?
SELECT count(a.actor_id), fa.film_id FROM actor as a
JOIN film_actor as fa
ON a.actor_id = fa.actor_id
JOIN film as fi
ON fa.film_id = fi.film_id
GROUP BY fa.film_id;


#Most active customer (the customer that has rented the most number of films)

SELECT c.customer_id, c.first_name, c.last_name, count(i.film_id) as 'count_of_films', count(r.rental_id) as 'count_of_rentals'
FROM customer as c
JOIN rental as r
ON c.customer_id = r. customer_id
LEFT JOIN inventory as i
ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id
HAVING count_of_films = count_of_rentals;


#Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, a.address, a.district, c.city, co.country FROM staff as s
JOIN address as a
ON s.address_id = a.address_id 
JOIN city as c
ON a.city_id = c.city_id
JOIN country as co
ON c.country_id = co.country_id;

#List each film and the number of actors who are listed for that film.

SELECT 
	f.film_id, 
    f.title, 
    count(a.actor_id) as 'number_of_actors'
FROM film as f
JOIN film_actor as fa
ON f.film_id = fa.film_id
JOIN actor as a
ON fa.actor_id = a.actor_id
GROUP BY f.film_id, f.title;

#Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. 
#List the customers alphabetically by last name.

SELECT  c.last_name, c.first_name, sum(p.amount)
FROM payment as p
JOIN customer as c
ON p.customer_id = c.customer_id
GROUP BY c.first_name
ORDER BY c.last_name;

SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

#List number of films per category.

SELECT c.category_id, c.name, count(f.film_id) as 'film_count'
FROM category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id = f.film_id
GROUP BY c.category_id;
