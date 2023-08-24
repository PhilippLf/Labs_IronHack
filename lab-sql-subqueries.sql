USE sakila;

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id = (SELECT film_id
                 FROM film
                 WHERE title = 'Hunchback Impossible');
                 
# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
                FROM film)
ORDER BY length;

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
                   FROM film_actor
                   WHERE film_id IN (SELECT film_id
                                     FROM film
								     WHERE title = 'ALONE TRIP'));

# 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
                  FROM film_category
                  WHERE category_id IN (SELECT category_id
                                        FROM category
                                        WHERE name = 'Family'));
                                        
# 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT first_name, last_name, email
FROM customer
	JOIN address
	USING(address_id)
    JOIN city
    USING(city_id)
WHERE country_id IN (SELECT country_id
                     FROM country
                     WHERE country='Canada');
                     
# 6.
SELECT title
FROM film
	JOIN film_actor
	USING(film_id)
WHERE actor_id = (SELECT actor_id
				  FROM film_actor
				  GROUP BY actor_id
				  ORDER BY COUNT(film_id) DESC
				  LIMIT 1);

# 7.
#SELECT * FROM film
#WHERE film_id IN (
#	SELECT film_id IN inventory
    
# 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
# You can use subqueries to accomplish this.
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_pc)
                             FROM (SELECT sum(amount) AS total_pc
					               FROM payment
                                   GROUP BY customer_id) AS total)
ORDER BY total_amount_spent DESC;