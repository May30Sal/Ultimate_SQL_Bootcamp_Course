/*
! Comparison and Logic Operators
*/

/*
! Comparison Operators equal (=) and not equal (!=)
*/

SELECT * FROM
    books
WHERE
    released_year != 2017;

/*
! LIKE and NOT LIKE
*/   

SELECT title FROM books WHERE title LIKE '% %';

SELECT title FROM books WHERE title NOT LIKE '% %';

/*
! GREATER THAN (>), LESS THAN (<) or EQUAL TO (=)
*/   
SELECT * FROM books WHERE released_year > 2005 
ORDER BY released_year;

SELECT * FROM books WHERE pages < 500;

SELECT * FROM books
WHERE released_year <= 1985;

SELECT 10 > 1;  /*TRUE in SQL will be 1*/
SELECT 10 < 1; /*FALSE in SQL will be 0*/
/* When comparing a value with NULL the answer will always be NULL */


/*
! LOGICAL OPERATORS AND (&&), OR (||), BETWEEN or NOT BETWEEN
*/ 
SELECT title, author_lname, released_year FROM books
WHERE released_year > 2010
AND author_lname = 'Eggers'
AND title LIKE '%novel%';

SELECT title, pages FROM books 
WHERE CHAR_LENGTH(title) > 30
OR pages > 500;

SELECT title, released_year FROM books WHERE released_year 
>= 2004 AND  released_year <= 2015;

SELECT title, released_year FROM books WHERE released_year
BETWEEN 2004 AND 2015; /* Includes 2004 and 2015! */

SELECT title, released_year FROM books WHERE released_year
NOT BETWEEN 2004 AND 2015; 


/*
! Comparing Dates
*/ 

SELECT * FROM people WHERE birthdate > "2005-01-01"; 
/* SQL can recognize a string that is a date, but is less 
precise! */


SELECT * FROM people WHERE YEAR(birthdate) > 2001; 

/* Convert string to a time */
SELECT CAST('09:00:00' AS TIME);

SELECT * FROM people WHERE birthtime 
BETWEEN CAST('12:00:00' AS TIME) 
AND CAST('16:00:00' AS TIME);

/*
! IN Operator
*/ 

SELECT title, author_lname FROM books WHERE
author_lname IN ('Lahiri', 'Gaiman');

SELECT title, author_lname FROM books WHERE
author_lname NOT IN ('Lahiri', 'Gaiman');

SELECT title, released_year from books 
where released_year % 2 = 0; 
/* Selecting all books released in a even year! */

/*
! CASE Statements and IS NULL
*/

SELECT title, released_year,
CASE
	WHEN released_year >= 2000 THEN 'modern lit'
    ELSE '20th century lit' 
END AS genre
FROM books;

SELECT 
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
        WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM
    books;

/* We cannot compare NULL using = or string, we need to use
the IS NULL */

SELECT * FROM books WHERE title IS NULL;


/*
! Exercises
*/ 

SELECT title, released_year 
FROM books
WHERE released_year < 1980;

SELECT title, author_lname
FROM books
WHERE author_lname IN ('Eggers', 'Chabon');

SELECT title, author_lname, released_year
FROM books
WHERE author_lname = 'Lahiri' AND released_year > 2000;

SELECT title, pages
FROM books
WHERE pages BETWEEN 100 AND 200;

SELECT title, author_lname 
FROM books
WHERE author_lname LIKE 'S%' OR author_lname LIKE 'C%';

SELECT title, author_lname,
CASE 
    WHEN title LIKE '%Stories%' THEN 'Short Stories'
    WHEN title LIKE '%Just Kids%' 
    OR title LIKE '%Heartbreaking%' THEN 'Memoir'
    ELSE 'Novel'
END AS 'Type'
FROM books;


SELECT author_fname, author_lname,
CASE
    WHEN COUNT(*) = 1 THEN '1 book'
    ELSE CONCAT(COUNT(*), ' books')
END
FROM books
GROUP BY author_fname, author_lname;


select * from books;