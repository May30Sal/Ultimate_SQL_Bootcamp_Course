/* creating and using a database */

CREATE database PetStore;

USE PetStore;

/* creating and describing a table */

CREATE TABLE cats
	(
		cat_id INT auto_increment,
        name VARCHAR(100),
        breed VARCHAR(100),
        age INT,
        PRIMARY KEY (cat_id)
	);
 
DESC cats;

/* inserting values in a table */

INSERT INTO cats (name, breed, age)
VALUES ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

/* Retrieving data from a table */

SELECT * FROM cats;
           
SELECT breed FROM cats;

SELECT name, age FROM cats;

/* It retrieves even if the name is in Upper or lower case*/

SELECT name, cat_id FROM cats WHERE name='Ringo';
SELECT name, cat_id FROM cats WHERE name='RINGO';

SELECT cat_id, age FROM cats WHERE cat_id=age;

/* creating a temporary alias for the column name when printing it out */

SELECT cat_id AS id, name FROM cats;

/* updating information */

UPDATE cats SET age=4; /* this is gonna update all the ages to 4 */

UPDATE cats SET breed='tabby' WHERE breed='teste'; 

SET SQL_SAFE_UPDATES = 0; SET SQL_SAFE_UPDATES = 1; /*change the error code 1175 deactivating the safety
 feature and activating again */
 
 UPDATE cats SET age=12 WHERE breed='Maine Coon'; 
 
/* deleting items from a table */

DELETE FROM cats WHERE name='egg';

DELETE FROM cats; /* delete everything from the table */

DROP TABLE cats; /* delete the table */

DELETE FROM cats WHERE age=cat_id;

SELECT * FROM cats;