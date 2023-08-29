USE sakila;


#List the number of films per category.

SELECT category_id, COUNT(title)
FROM film as f
	JOIN film_category as fc
	USING (film_id)
group by category_id;

#Retrieve the store ID, city, and country for each store.

SELECT store_id, city_id, country_id
FROM city as c
	JOIN address as a
	USING (city_id)
    JOIN store as s
    USING (address_id)
group by s.store_id;


#Calculate the total revenue generated by each store in dollars.

SELECT store_id, SUM(amount) as total_revenue
FROM payment as p
	JOIN staff as a
	USING (staff_id)
group by store_id;

#Determine the average running time of films for each category.

SELECT category_id, AVG(length) as avg_runnning_time
FROM film_category as category
	JOIN film
	USING (film_id)
group by category_id;

#Identify the film categories with the longest average running time.

SELECT name,AVG(length) as avg_runnning_time
FROM category
	JOIN film_category
	USING (category_id)
    JOIN film
    USING (film_id)
group by category.name
ORDER BY avg_runnning_time DESC;


#Display the top 10 most frequently rented movies in descending order.

SELECT title, COUNT(rental_id) as nr_of_rented
FROM rental
	JOIN inventory
    USING (inventory_id)
    JOIN film
    USING (film_id)
group by title
order by nr_of_rented DESC
Limit 10;

#Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT title, store_id
FROM store
	JOIN inventory
    USING (store_id)
    JOIN film
    USING (film_id)
WHERE title  = 'ACADEMY DINOSAUR';

# Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' 
# Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."

SELECT DISTINCT(title), inventory_id,
   CASE 
		WHEN return_date IS NULL 
		THEN 'not available' 
		ELSE 'available' 
		END AS availablity
FROM film   
	JOIN inventory
    USING (film_id)
    LEFT JOIN rental
    USING (inventory_id);

