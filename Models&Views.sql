/*
! VIEWS and WINDOW FUNCTIONS
*/ 
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

SELECT * FROM full_reviews;
/*
! NOW WE CAN TREAT THAT VIEW AS A VIRTUAL TABLE 
*/

/* 
! Some views can be updated (delete or insert items) depending
! if they follow the rules (see in SQL docs), like not having
! a Joint, group by, etc. When we update in the view we also
! update in the real table.
*/

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

SELECT * FROM ordered_series;

INSERT INTO ordered_series (title, released_year, genre) VALUES
('The Great', 2000, 'Comedy');

/*
! Updating/alterings views
*/

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;

ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

DROP VIEW ordered_series;

/*
! HAVING clause: used to filter the groups that we get back
! from GROUP BY
*/
SELECT
    title,
    AVG(rating),
    COUNT(rating) AS review_count
FROM
    full_reviews
GROUP BY
    title
HAVING
    COUNT(rating) > 1;

/*
! ROLLUP: returns a summary of all rows (show as null).
! Only works with GROUP BY
*/

SELECT 
    title, AVG(rating)
FROM
    full_reviews
GROUP BY title WITH ROLLUP;

/* 
! SQL MODE is a SQL system variable meant to configure 
! operational characteristics of the MySQL server. You apply
! SQL modes depending on the clients. You can change the SQL 
! mode by using the sql_mode system variable.
*/

SHOW warnings;

-- To View Modes:
SELECT @@GLOBAL.sql_mode;

SELECT @@SESSION.sql_mode;

-- To Set Them:
SET
    GLOBAL sql_mode = 'modes';

SET SESSION sql_mode = 'modes';

/* 
! Strict SQL Mode: controls how SQL handles invalid or missing
! values. Ex: when we try to insert 'hi' instead of a number 
! in a INT statement.
*/

SET SESSION sql_mode = ''; /*disables all modes*/

/*
! WINDOW Functions: performe aggregate operations on group
! of rows, but produce one result for each row.

! OVER() constructs a window (group) and when it's empty will
! include records for all the rows.

*/
USE bookstore;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

SELECT emp_no, department, salary, AVG(salary) OVER() 
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;


SELECT 
    emp_no, department, salary, MIN(salary), MAX(salary)
FROM
    employees;

/*
! PARTITION BY() used inside of a OVER() to form rows into
! groups of rows.
*/

SELECT 
    emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;

/*
! ORDER BY() used inside of a OVER() to re-order rows within
! each window.
*/

SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

/*
! RANK() only work with OVER() and as a window function, 
! will rank the results with gaps.

! DENSE_RANK() will rank the results without gaps.

! ROW_NUMBER will write the numbers of the rowns.
*/

    SELECT 
        emp_no, 
        department, 
        salary,
        ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number,
        RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank,
        RANK() OVER(ORDER BY salary DESC) as overall_rank,
        DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
        ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
    FROM employees ORDER BY overall_rank;

/*
! NTILE() only work with OVER() and as a window function, 
! will rank the results with gaps.
! FIRST_VALUE
! LAG()
! LEAD()
*/  