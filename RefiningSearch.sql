USE bookstore;

INSERT INTO
    books (
        title,
        author_fname,
        author_lname,
        released_year,
        stock_quantity,
        pages
    )
VALUES
    ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
    ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
    (
        'Lincoln In The Bardo',
        'George',
        'Saunders',
        2017,
        1000,
        367
    );

SELECT
    *
FROM
    books;

/* 
! Select without duplicates 
*/
SELECT
    Distinct author_lname
FROM
    books;

SELECT
    Distinct CONCAT (author_fname, ' ', author_lname)
FROM
    books;

SELECT
    Distinct author_fname,
    author_lname
FROM
    books;

/*
! ORDER BY select items in alphabetical order (strings) or numbers 
*/
SELECT
    author_fname,
    author_lname
FROM
    books
ORDER BY
    author_fname;

SELECT
    author_fname,
    author_lname
FROM
    books
ORDER BY
    author_fname DESC;

/*descending alphabetical order */
SELECT
    author_fname,
    author_lname,
    released_year
FROM
    books
ORDER BY
    2;

/* 
! number of the argument u want ot order by
! ordering one column and then the other 
*/
SELECT
    book_id,
    released_year,
    author_lname,
    pages
FROM
    books
ORDER BY
    author_lname,
    released_year;

/* 
! LIMIT will limit the results we select 
*/
SELECT
    title,
    released_year
FROM
    books
ORDER BY
    released_year
LIMIT
    7;

/* 
! to select intervals use 2 arguments (ex: 5, 2): the 1st is the starting point and the 2nd is the count of rows) 
*/

/* 
! LIKE helps with basic searching with wildcard characters
*/
SELECT
    author_fname, 
    title
FROM
    books
WHERE
    author_fname LIKE '%dav%'; /* 
    ! what's between the % signs is what it will look for 
    */

SELECT
    author_fname, 
    title
FROM
    books
WHERE
    author_fname LIKE '_____'; 
    /*
    ! will look for author name with exaclty  caracteres (5 underscores) or if u do _a_ will look for a name with 3 characters 
    ! where the middle one is an a
    */


/* 
! exercises
*/

SELECT title FROM books WHERE title LIKE '%stories%';

SELECT
    title,
    pages
FROM
    books
ORDER BY
    pages DESC
LIMIT
    1;

SELECT
    Distinct title, released_year
FROM
    books
ORDER BY
    released_year DESC
LIMIT
    3;

SELECT
    concat (title, ' - ', released_year) AS Summary
FROM
    books
ORDER BY
    released_year DESC
LIMIT
    1, 3;

SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname LIKE '% %';

SELECT
    title,
    released_year, 
    stock_quantity
FROM 
    books
ORDER BY
    stock_quantity,
    released_year DESC
LIMIT
    3;

SELECT
    title,
    author_lname
FROM
    books
ORDER BY
    author_lname,
    title;

SELECT 
    UCASE (
        CONCAT(
            'My favorite author is ',
            author_fname,
            ' ',
            author_lname,
            '!'
        )
    )
AS 
    yell
FROM
    books
ORDER BY
    author_lname;

SELECT * FROM books;
