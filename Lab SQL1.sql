USE sakila;
SHOW TABLES;


SELECT *
FROM actor, film, customer;

Select title
FROM film;

SELECT language_id as language_from_the_language_table
FROM film;

SELECT first_name
FROM staff;

SELECT DISTINCT(release_year)
FROM film;

SELECT COUNT(store_id)
FROM inventory;

SELECT COUNT(staff_id)
FROM staff;

SELECT COUNT(rental_id)
FROM rental;

SELECT COUNT(return_date)
FROM rental;

SELECT COUNT(rental_id)
FROM rental
WHERE return_date IS NULL;

SELECT COUNT(actor_id)
FROM film_actor;

SELECT length as max_movie
FROM film
ORDER BY max_movie DESC
LIMIT 1;

SELECT first_name as 'Scarletts'
FROM actor
WHERE first_name Like 'Scarlett';


SELECT title as 'ARMS'
FROM film
WHERE title LIKE '%ARMAGEDDON%' and length > 100;




