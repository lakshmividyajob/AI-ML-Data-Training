#1.Customers who made more than 5 payments
SELECT c.*
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT(p.payment_id) > 5;

#2. Actors who acted in more than 10 films
SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10;

#3. Customers who never made a payment
SELECT c.*
FROM customer c
LEFT JOIN payment p
    ON c.customer_id = p.customer_id
WHERE p.payment_id IS NULL;

#4. Films with rental rate higher than average
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

#5. Films that were never rented
SELECT f.title
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

#6. Customers who rented films in the same month as customer ID 5
SELECT DISTINCT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
WHERE MONTH(r.rental_date) IN (
    SELECT MONTH(rental_date)
    FROM rental
    WHERE customer_id = 5
);

#7. Staff who handled payment greater than average payment
SELECT DISTINCT
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name
FROM staff s
JOIN payment p
    ON s.staff_id = p.staff_id
WHERE p.amount > (
    SELECT AVG(amount)
    FROM payment
);

#8. Films with rental duration greater than average
SELECT title, rental_duration
FROM film
WHERE rental_duration > (
    SELECT AVG(rental_duration)
    FROM film
);

#9. Customers with same address as customer ID 1
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    address_id
FROM customer
WHERE address_id = (
    SELECT address_id
    FROM customer
    WHERE customer_id = 1
)
AND customer_id <> 1;

#10. Payments greater than average payment
SELECT *
FROM payment
WHERE amount > (
    SELECT AVG(amount)
    FROM payment
);