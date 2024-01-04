CREATE DATABASE shirts_db;

USE shirts_db;

CREATE TABLE shirts
	(
		shirt_id INT auto_increment PRIMARY KEY,
        article VARCHAR(100),
        color VARCHAR(50),
        shirt_size VARCHAR(50),
        last_worn INT
	);
    
DESC shirts;

INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('T-shirt', 'white', 'G', 15),
	   ('T-shirt', 'black', 'M', 5),
       ('Tank Top', 'pink', 'M', 20),
       ('T-shirt', 'pink', 'P', 19),
       ('Tank Top', 'white', 'G', 89),
       ('Polo', 'green', 'G', 14),
       ('Polo', 'white', 'G', 28);
 
 SELECT * FROM shirts;
 
 INSERT INTO shirts (article, color, shirt_size, last_worn)
 VALUES ('Polo', 'purple', 'M', 50);

SELECT article, color, shirt_size FROM shirts WHERE shirt_size='M';

UPDATE shirts SET shirt_size='L' WHERE article='Polo';

UPDATE shirts SET last_worn=0 WHERE last_worn=15;

UPDATE shirts SET color='off-white', shirt_size='XS' WHERE color='white';

DELETE FROM shirts WHERE last_worn>=50;

DELETE FROM shirts WHERE article='Tank Top';

SHOW databases;

SHOW TABLES;

DROP TABLE shirts;


