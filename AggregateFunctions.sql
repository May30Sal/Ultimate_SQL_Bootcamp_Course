/*
! Aggregate Functions
*/

/*
! Counting the # of rows in a table with COUNT
*/
SELECT COUNT (*) FROM books; 

SELECT COUNT (DISTINCT author_lname) FROM books;

SELECT COUNT (title) FROM books WHERE title LIKE '%the%';

/*
! GROUP BY aggregates identical data into single rows
*/
SELECT author_lname FROM books GROUP BY author_lname;

SELECT DISTINCT author_lname FROM books;

SELECT author_lname,  COUNT (*) FROM books 
GROUP BY author_lname;

/*
! MIN and MAX (can be used on text and will bring the 
! min/max in alphabetical order
*/
SELECT MIN(released_year) FROM books;

SELECT MAX(released_year) FROM books;

/*
! Subsqueries
*/
SELECT title, pages FROM books
WHERE pages = (SELECT MIN(pages) FROM books);

/*
! You can select a specific row
*/
select * from books; LIMIT 14,1; 

/*
! Grouping by multiple columns
*/
SELECT author_fname, author_lname, COUNT(*) 
FROM books 
GROUP BY author_lname, author_fname;
     
     
SELECT CONCAT(author_fname, ' ', author_lname) AS author,  COUNT(*)
FROM books
GROUP BY author;

SELECT author_fname, MIN(released_year) FROM books GROUP BY author_fname;

SELECT
    author_lname,
    author_fname,
    COUNT(*) AS books_written,
    MAX(released_year) AS latest_release,
    MIN(released_year) AS earliest_release
FROM
    books
GROUP BY
    author_lname,
    author_fname;

/*
! SUM & AVG
*/

SELECT 
    author_fname, 
    author_lname, 
    SUM(pages) AS pages_written 
FROM 
    books 
GROUP BY 
    author_fname, 
    author_lname;

SELECT
    AVG (released_year)
FROM
    books;

SELECT
    author_fname,
    author_lname,
    AVG (released_year)
FROM
    books
GROUP BY
    author_fname,
    author_lname;

/*
! Exercises
*/

SELECT COUNT (*) FROM books;

SELECT
   released_year,
   COUNT(*)
FROM
    books
GROUP BY
    released_year;

SELECT
    SUM(stock_quantity)
FROM
    books;

SELECT
    author_fname,
    author_lname,
    AVG (released_year)
FROM
    books
GROUP BY
    author_fname,
    author_lname;

SELECT
    CONCAT (author_fname, ' ', author_lname) AS author,
    pages
FROM
    books
WHERE pages = (SELECT MAX(pages) FROM books);

SELECT
    released_year as 'year',
    COUNT(*) AS '# books',
    AVG(pages) as 'avg pages'
FROM    
    books
GROUP BY
    released_year
ORDER BY
    released_year;








