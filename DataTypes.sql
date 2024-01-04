/* 
! Data Types 

! TINYINT (max 127), SMALLINT, INT, MEDIUMINT, BIGINT - UNSIGNED is to not allowing negative numbers
! VARCHAR is used to store text with different length sizes (ex: names, etc.)
! CHAR is used to store text in fixed lenght sizes (ex: zip-codes, states, Y/N answers, etc.)
! DECIMAL is used to store precised decimals (ex: DECIMAL 5,2 -> 1st is the max digits total and 2dn 
! is max after the comma, like 999,99)
! FLOAT (precise until 7 digit) and DOUBLE (precise until 15 digit) use less space to store, bust 
! is less precise.
! DATE is stored as YYYY-MM-DD and used only for dates
! TIME is stored as HH:MM:SS and used only for times
! DATETIME is stored as YYYY-MM-DD HH:MM:SS
*/
USE bookstore

CREATE TABLE people (
    name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);

INSERT INTO
    people (name, birthdate, birthtime, birthdt)
VALUES
    (
        'Elton',
        '2000-12-25',
        '11:00:00',
        '2000-12-25 11:00:00'
    );

INSERT INTO
    people (name, birthdate, birthtime, birthdt)
VALUES
    (
        'Lulu',
        '1985-04-11',
        '9:45:10',
        '1985-04-11 9:45:10'
    );

INSERT INTO
    people (name, birthdate, birthtime, birthdt)
VALUES
    (
        'Juan',
        '2020-08-15',
        '23:59:00',
        '2020-08-15 23:59:00'
    );

INSERT INTO
    people (name, birthdate, birthtime, birthdt)
VALUES
    ('Hazel', CURDATE(), CURTIME(), NOW());

SELECT * FROM people;

/* 
! working with dates and times
*/
SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();

/* 
! Extracting specific info about dates
*/

SELECT
    birthdate,
    DAYOFMONTH(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM
    people;

SELECT
    name,
    birthdt,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM
    people;

/* 
! Extracting specific info about time
*/

SELECT
    birthtime,
    HOUR(birthtime),
    MINUTE(birthtime),
    SECOND(birthtime)
FROM
    people;

SELECT
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM
    people;

/* 
! Formating dates and times (check the docs for more options)
*/
SELECT
    birthdate,
    DATE_FORMAT(birthdate, '%a %b %D')
FROM
    people;

SELECT
    birthdt,
    DATE_FORMAT(birthdt, '%H:%i')
FROM
    people;

SELECT
    birthdt,
    DATE_FORMAT(birthdt, 'BORN ON: %r')
FROM
    people;

/* 
! Calculating with dates and times
*/

/* 
! Calculating date or time difference between 2 values
*/
SELECT DATEDIFF(CURDATE(), birthdate) FROM people;
SELECT TIMEDIFF(CURTIME(), birthtime) FROM people;

/* 
! Calculating dates or times: adding or subtracting values
*/
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);
SELECT DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT ADDTIME(CURTIME(), '2:00:00');
SELECT SUBTIME(CURTIME(), '2:00:00');

SELECT name, birthdate, YEAR(birthdate + INTERVAL 21 YEAR) FROM people;

/* 
! TIMESTAMPS: combine dates and times (use less space in memory bc goes from 1978 to 2038)
! Used to track times, ex: update on an instagram post
*/
CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions (text) VALUES (
    'beautiful sunset!!!'
);

INSERT INTO captions (text) VALUES (
    'Just chillin!!!'
);

Update captions SET text='Nice sunset!!!' WHERE text='beautiful sunset!!!'

SELECT * FROM captions;


/* 
! Exercises
*/

SELECT CURTIME();
SELECT CURDATE();
SELECT DAYOFWEEK(CURDATE());
SELECT DAYNAME(CURDATE());
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');

CREATE TABLE tweets (
    username VARCHAR(50),
    content VARCHAR(180),
    created_at TIMESTAMP default CURRENT_TIMESTAMP
);

INSERT INTO tweets (username, content) VALUES (
    'Maya25', 'beautiful sunset!!!'
);

DESC tweets;

SELECT * FROM tweets;
