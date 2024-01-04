/* String functions */

CREATE DATABASE bookstore;

USE bookstore;

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM books;

/* combining data with CONCAT*/

SELECT CONCAT(author_fname, ' ', author_lname) AS author_FullName FROM books;

SELECT CONCAT_WS('_', author_fname, author_lname) AS author_FullName FROM books; /* concat with separator /*

/* extracting parts of a string with SUBSTRING*/

SELECT SUBSTRING('Hello World', 1, 4); /*string, starting caracter, ending caracter. Without the 2nd caracter will go till the end */

SELECT SUBSTRING('Hello World', -1); /* will count backwords */

SELECT SUBSTR(title, 1, 15) FROM books; /* using in a column */

SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS Books FROM books; 

/* click at the brush in the workbench to beautify the code */
SELECT 
    CONCAT(SUBSTR(author_fname, 1, 1),
            '. ',
            SUBSTR(author_lname, 1, 1),
            '.') AS Author_Initials
FROM
    books;

/* Using REPLACE to replace strings (but not the data itself). It's case sensitive! */

SELECT REVERSE
		('today'); 

SELECT char_length('today'); /*provides the length of a string. The SELECT length returns the number of bites used. */

SELECT char_length(title) FROM books;

SELECT LOWER (title) FROM books; /*turning to lowercase. Or can use LCASE*/

SELECT UPPER (title) FROM books; /*turning to uppercase Or can use UCASE*/

SELECT CONCAT
	('I love ', UCASE(title), ' !!!')
FROM
	books;

/*Inserting caracteres in a string: string, char to start,
char to replace, string/char we are adding*/

SELECT INSERT('Hello Bob', 6, 0, ' there'); 

SELECT INSERT('Hello Bob', 6, 2, ' R'); 

SELECT REPEAT('Hello Bob ', 2); 

SELECT REVERSE(UCASE ('Why does my cat look at me with suh hatred?'));


SELECT REPLACE
	(title,
	' ',
	'->')
AS 
	title
FROM
	books;


SELECT 
	author_lname 
AS 
	forwards,
REVERSE
	(author_lname) 
AS 
	backwards 
FROM
	books;


SELECT CONCAT
	(UCASE (author_fname), ' ', UCASE (author_lname))
AS
	'full name in caps'
FROM
	books;

SELECT CONCAT
	(title, ' was released in ', released_year)
AS
	blurb
FROM
	books;


SELECT
	title,
	char_length(title) 
	AS
		'character count'
FROM
	books;

SELECT
	CONCAT (SUBSTR(title, 1, 10), '...')
	AS
		'short title',
	CONCAT (author_lname, ", ", author_fname)
	AS
		'author',
	CONCAT (stock_quantity, ' in stock')
	AS
		'quantity'
FROM
	books;









/* Make the server work in Vs Code */    
CREATE USER 'sqluser'@'%' IDENTIFIED 
WITH mysql_native_password BY 'Estojokin@88' ;

GRANT ALL PRIVILEGES ON *.* TO 'sqluser'@'%' ;

FLUSH PRIVILEGES;













