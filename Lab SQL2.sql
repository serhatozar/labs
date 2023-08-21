
USE sakila;

#CHALLENGE 1

#1.1
SELECT MIN(length) as min_duration
FROM film;

SELECT max(length) as max_duration
FROM film;

#1.2
SELECT FLOOR(AVG(length) / 60) AS average_hours, ROUND(AVG(length) % 60) AS average_minutes
FROM film;

#2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

#2.2
SELECT *,EXTRACT(MONTH FROM rental_date) AS rental_month, EXTRACT(DAY FROM rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#2.3

SELECT rental_date, IF(weekday(rental_date) IN (5,6), 'weekend', 'weekday') as DAY_TYPE
FROM rental;

#3 




#CHALLENGE 2

#1.1
SELECT COUNT(film_id)
FROM film;

#1.2
SELECT DISTINCT(rental_rate)
FROM film;

#1.3
SELECT rating, COUNT(*) as nr_film_rates
FROM film
group by rating
order by nr_film_rates DESC;

#2 number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary.

SELECT staff_id, COUNT(rental_id) as emp_perform
FROM rental
group by staff_id;

#3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.

SELECT rental_rate, ROUND(AVG(length),2) as rate_duration
FROM film
group by rental_rate
order by rate_duration DESC;

#3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
SELECT rating, AVG(length) as rate_dur_2
FROM film
WHERE length > 120
group by rating
Order by rate_dur_2 desc;

#4 Determine which last names are not repeated in the table actor.

SELECT last_name as count_ln
FROM actor
group by last_name
HAVING count_ln < 1;