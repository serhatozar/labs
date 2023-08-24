USE sakila;

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(film_id)
FROM film
		JOIN inventory
        USING (film_id)
WHERE title = 'Hunchback Impossible';

#List all films whose length is longer than the average length of all the films in the Sakila database

SELECT title
FROM film
WHERE length > (SELECT AVG(length)
                FROM film);


#Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id IN (SELECT film_id
									FROM film 
                                    WHERE title = 'Alone Trip'));
                                    
#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT *,
CASE category WHEN name is not 'family' THEN 'family' END as category_name
FROM category;

#etrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

CREATE VIEW family_movies AS
SELECT title, category
		JOIN film_category
        USING(film_id)
        JOIN category
        USING (category_id)
FROM film
WHERE category = 'Family';
                 
