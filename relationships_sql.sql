-- RELATIONSHIP TYPES

--  1:1 JOIN — users ↔ user_profiles
-----------------------------------
-- Inner Join: Only users with profiles
select * from joins.users;
select * from  joins.user_profiles;

SELECT u.user_id, u.user_name, p.profile_status
FROM  joins.users u
INNER JOIN joins.user_profiles p ON u.user_id = p.user_id;

-- Left Join: All users, with profile if present
select * from joins.users;

SELECT u.user_id, u.user_name, p.profile_status
FROM joins.users u
LEFT JOIN joins.user_profiles p ON u.user_id = p.user_id;
-- where p.user_id is null;

SELECT u.user_id, u.user_name, p.profile_status
FROM joins.users u
RIGHT JOIN joins.user_profiles p ON u.user_id = p.user_id;


-- 1:Many JOIN — users ↔ orders
-------------------------------

-- Each user may have many orders

SELECT u.user_id, u.user_name, o.order_id, o.order_status
FROM joins.users u
left JOIN joins.orders o ON u.user_id = o.user_id;


-- Many:1 JOIN — orders → users
-------------------------------
-- Many orders per user (same as above but reversed logic)

SELECT o.order_id, o.order_status, u.user_name
FROM joins.orders o
JOIN joins.users u ON o.user_id = u.user_id;

 -- Many:Many JOIN — users ↔ users (friendships)
-----------------------------------------------

-- Self join through friendship table

SELECT u.user_name AS user, f.user_name AS friend
FROM joins.friendships fs
JOIN joins.users u ON fs.user_id = u.user_id
JOIN joins.users f ON fs.friend_id = f.user_id;

----------------------------------------------------------------------------

-- TYPES OF JOINS

-- INNER JOIN
-------------
-- Returns matching rows from both tables

SELECT u.user_name, o.order_id
FROM joins.users u
INNER JOIN joins.orders o ON u.user_id = o.user_id;

 -- LEFT JOIN
------------
-- Returns all users even if they don't have orders

SELECT u.user_name, o.order_id
FROM joins.users u
LEFT JOIN joins.orders o ON u.user_id = o.user_id;

#unmatched 

SELECT u.user_name, o.order_id
FROM joins.users u
LEFT JOIN joins.orders o ON u.user_id = o.user_id
where o.user_id is null;

-- RIGHT JOIN
-------------
-- Returns all orders even if they don't match a user

SELECT u.user_name, o.order_id
FROM joins.users u
RIGHT JOIN joins.orders o ON u.user_id = o.user_id;

-- FULL OUTER JOIN (not directly supported in MySQL)
-----------------------------------------------------
-- Simulated using UNION of LEFT and RIGHT

SELECT u.user_name, o.order_id
FROM joins.users u
LEFT JOIN joins.orders o ON u.user_id = o.user_id
UNION
SELECT u.user_name, o.order_id
FROM joins.users u
RIGHT JOIN joins.orders o ON u.user_id = o.user_id;

-- CROSS JOIN
-------------
-- Returns Cartesian product (every user with every order)

SELECT u.user_name, o.order_id
FROM joins.users u
CROSS JOIN joins.orders o;



-- SELF JOIN
------------
-- Users and their friends (mutual or one-way)

SELECT u.user_name AS user, f.user_name AS friend
FROM joins.users u
JOIN joins.friendships fs ON u.user_id = fs.user_id
JOIN joins.users f ON fs.friend_id = f.user_id;



-----------------
#to exclude 
SELECT o.order_id, o.user_id, u.user_name
FROM joins.orders o
LEFT JOIN joins.users u ON o.user_id = u.user_id
where u.user_id is null;



----------------
#### distinct + joins 

SELECT distinct c.customer_id, c.first_name, r.*
FROM sakila.customer c
JOIN sakila.rental r ON c.customer_id = r.customer_id;



-------------

SELECT
  @dob   := DATE('1998-04-18')                              AS dob,
  @today := CURDATE()                                       AS today,
  @yrs   := TIMESTAMPDIFF(YEAR, @dob, @today)               AS yrs,
  @mons  := TIMESTAMPDIFF(MONTH, DATE_ADD(@dob, INTERVAL @yrs YEAR), @today) AS mons,
  CONCAT(@yrs, ' years, ', @mons, ' months, ',
         DATEDIFF(@today, DATE_ADD(DATE_ADD(@dob, INTERVAL @yrs YEAR), INTERVAL @mons MONTH)),
         ' days') AS age_ymd;



