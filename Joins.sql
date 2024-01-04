/* 
! Relationship Basics and Joins
! One to one, one to many, many to many
!
*/
USE bookstore;

DESC orders;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) VALUES 
    ('Boy', 'George', 'george@gmail.com'),
    ('George', 'Michael', 'gm@gmail.com'),
    ('David', 'Bowie', 'david@gmail.com'),
    ('Blue', 'Steele', 'blue@gmail.com'),
    ('Bette', 'Davis', 'bette@aol.com');


INSERT INTO orders (order_date, amount, customer_id) VALUES 
    ('2016-02-10', 99.99, 1),
    ('2017-11-11', 35.50, 1),
    ('2014-12-12', 800.67, 2),
    ('2015-01-03', 12.50, 2),
    ('1999-04-11', 450.25, 5);

SELECT * FROM customers, orders; /* Join all without a logic */

/* 
! Cross Join
*/
SELECT id FROM customers WHERE last_name = 'George';
SELECT * FROM orders WHERE customer_id = 1;

SELECT * FROM orders 
WHERE customer_id = 
(SELECT id FROM customers WHERE last_name = 'George');


/* 
! Inner Join: select the records from A and B only where the
! join condition is met
*/
SELECT * FROM customers
INNER JOIN orders ON orders.customer_id = customers.id;

SELECT first_name, last_name, amount FROM customers
INNER JOIN orders ON orders.customer_id = customers.id;

SELECT
    first_name,
    last_name,
    SUM(amount) AS total
FROM
    customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY
    first_name,
    last_name
ORDER BY
    total DESC;

/* 
! Left Join: select all the records from A, along with the
! matching records in B
*/

SELECT
    first_name,
    last_name,
    order_date,
    amount
FROM
    customers
    LEFT JOIN orders ON orders.customer_id = customers.id;

SELECT
    first_name,
    last_name,
    IFNULL(SUM(amount), 0) AS money_spent
FROM
    customers
    LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY
    first_name,
    last_name;

/* 
! Right Join: select all the records from B, along with the
! matching records in A
*/

SELECT
    first_name,
    last_name,
    order_date,
    amount
FROM
    customers
    RIGHT JOIN orders ON customers.id = orders.customer_id;

/* 
! ON DELETE CASCADE
! When we try to delete a customer from the table customers
! it will send an error, because the constraint for the
! orders table is that we cannot have an order without a 
! customer. The options are: delete all the orders made by
! that customer and then delete the customer (using ON DELETE
! CASCADE; or update the customer_id to be something like 
! 'deleted' or NULL.
*/

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (id) 
    ON DELETE CASCADE
);

/*
! Exercises
*/

CREATE table students 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR (50)
);

CREATE TABLE papers
(
    title VARCHAR(50),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

DESC papers;

INSERT INTO students (first_name)
VALUES ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade)
VALUES 
(1, 'My first book report', 60),
(1, 'My second book report', 75),
(2, 'Russian lit throught the ages', 94),
(2, 'De Montaigne and the art of the essay', 98),
(4, 'Borges and magical realism', 89);

SELECT * FROM papers;

SELECT first_name, title, grade
FROM students
INNER JOIN papers
    ON students.id = papers.student_id
ORDER BY grade DESC;

SELECT first_name, title, grade
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id;

SELECT first_name, IFNULL(title, "MISSING"), IFNULL(grade, 0)
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id;

SELECT first_name, IFNULL(AVG(grade), 0)
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY first_name;

SELECT first_name, IFNULL(AVG(grade), 0) AS average,
CASE
    WHEN AVG(grade) >= 75 THEN 'passing'
    ELSE 'failing'
END AS passing_status
FROM students
LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;

/*
! Many to Many
*/
CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);

CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series (id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers (id)
);

INSERT INTO
    series (title, released_year, genre)
VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO
    reviewers (first_name, last_name)
VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');

INSERT INTO
    reviews(series_id, reviewer_id, rating)
VALUES
    (1, 1, 8.0),
(1, 2, 7.5),
(1, 3, 8.5),
(1, 4, 7.7),
(1, 5, 8.9),
    (2, 1, 8.1),
(2, 4, 6.0),
(2, 3, 8.0),
(2, 6, 8.4),
(2, 5, 9.9),
    (3, 1, 7.0),
(3, 6, 7.5),
(3, 4, 8.0),
(3, 3, 7.1),
(3, 5, 8.0),
    (4, 1, 7.5),
(4, 3, 7.8),
(4, 4, 8.3),
(4, 2, 7.6),
(4, 5, 8.5),
    (5, 1, 9.5),
(5, 3, 9.0),
(5, 4, 9.1),
(5, 2, 9.3),
(5, 5, 9.9),
    (6, 2, 6.5),
(6, 3, 7.8),
(6, 4, 8.8),
(6, 2, 8.4),
(6, 5, 9.1),
    (7, 2, 9.1),
(7, 5, 9.7),
    (8, 4, 8.5),
(8, 2, 7.8),
(8, 6, 8.8),
(8, 5, 9.3),
    (9, 2, 5.5),
(9, 3, 6.8),
(9, 4, 5.8),
(9, 6, 4.3),
(9, 5, 4.5),
    (10, 5, 9.9),
    (13, 3, 8.0),
(13, 4, 7.2),
    (14, 2, 8.5),
(14, 3, 8.9),
(14, 4, 8.9);

SELECT * FROM reviewers;
SELECT * FROM reviews;
SELECT * FROM series;

SELECT title, rating
FROM series
LEFT JOIN reviews
ON series.id = reviews.series_id;

SELECT title, ROUND(AVG(rating), 2) AS average_rating
FROM series
JOIN reviews
ON series.id = reviews.series_id
GROUP BY title
ORDER BY average_rating ASC;

SELECT first_name, last_name, rating
FROM reviewers
JOIN reviews
ON reviewers.id = reviews.reviewer_id;

SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews
ON series.id = reviews.series_id
WHERE rating IS NULL;

SELECT genre, ROUND(AVG(rating), 2) AS average_rating
FROM series
JOIN reviews
ON series.id = reviews.series_id
GROUP BY genre;

SELECT first_name, last_name, 
COUNT(rating) AS COUNT,
IFNULL(ROUND(MIN(rating), 2), 0) AS MIN,
IFNULL(ROUND(MAX(rating), 2), 0) AS MAX, 
IFNULL(ROUND(AVG(rating),2), 0) AS AVG,
CASE   
    WHEN COUNT(rating) > 0 THEN 'ACTIVE'
    ELSE 'INACTIVE'
END AS 'STATUS'
/*
! (option) IF(COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') 
! AS status
*/ 
FROM reviewers
LEFT JOIN reviews
ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

SELECT title, rating, 
CONCAT(first_name, ' ', last_name) AS reviewer
FROM series
JOIN reviews
ON series.id = reviews.series_id
JOIN reviewers
ON reviewers.id = reviews.reviewer_id
ORDER BY title;
