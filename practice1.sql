USE Sakila;
select * from actor;
-- Day 1 SQL
USE Sakila;
select * from actor;
CREATE DATABASE IF NOT EXISTS practice_db;
use practice_db;
DROP TABLE students;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);
INSERT INTO students (name, age, city)
VALUES 
('Ramya', 24, 'New York'),
('John', 26, 'Boston'),
('Sara', 22, 'Chicago');
SELECT * FROM students;
SELECT * FROM students
WHERE age > 23;
UPDATE students
SET age = 25
WHERE id = 1;
DELETE FROM students
WHERE name = 'John' limit 1;
ALTER TABLE students
ADD email VARCHAR(100);
RENAME TABLE students TO student_data;
SELECT DATABASE();
SHOW TABLES;
SHOW DATABASES;