USE sakila;

# 1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM sakila.film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT ROUND(AVG(length))
FROM sakila.film;

# 2. We need to use SQL to help us gain insights into our business operations related to rental dates:
# 2.1 Calculate the number of days that the company has been operating.
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
    rental_id,
    rental_date,
    return_date,
    # Extracting month and weekday
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    sakila.rental
LIMIT 20;

# 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT
    rental_id,
    rental_date,
    return_date,
    # Adding DAY_TYPE column using a conditional expression
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM
    sakila.rental
LIMIT 20;

# 3. We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles and their rental duration.
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order.
# Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
SELECT
    title AS film_title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
    sakila.film
ORDER BY
    film_title ASC;
    
# 4. As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers.
# To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations.
# The results should be ordered by last name in ascending order to make it easier for us to use the data.    
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM
    sakila.customer
ORDER BY
    last_name ASC;
    
# CHALLENGE 2
# 1.1
SELECT COUNT(*) AS total_films_released
FROM sakila.film;

# 1.2
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating;

# 1.3
SELECT rating, COUNT(*) AS num_films
FROM sakila.film
GROUP BY rating
ORDER BY num_films DESC;

# 2.
SELECT
    staff_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    COUNT(*) AS num_rentals_processed
FROM
    sakila.rental
JOIN
    staff ON rental.staff_id = staff.staff_id
GROUP BY
    staff_id, employee_name
ORDER BY
    num_rentals_processed DESC;
    
# 3.1
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    sakila.film
GROUP BY
    rating
ORDER BY
    mean_duration DESC;

#3.2
SELECT
    rating
FROM
    sakila.film
GROUP BY
    rating
HAVING
    AVG(length) > 120;

# 4.    
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
