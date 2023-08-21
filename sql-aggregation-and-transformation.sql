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
FROM sakila.rental;