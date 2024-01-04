/* 
! Constraints and ALTER tables 
*/

/* 
! UNIQUE establish that the value can not be a duplicate
! CHECK will check if the value is true or false (we can name it)
*/

CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    age INT,
    CONSTRAINT age_over_18 CHECK (age > 18)
);

Insert into contacts (name, phone, age) values('ana', '4789658', 17);

Insert into contacts (name, phone, age) values('ana', '0', 19);

select * from contacts;

/* 
! We can use UNIQUE for combinations of values, ex: name and adress.
*/

CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

Insert into companies (name, address) values('ana', '47 st NW');

Insert into companies (name, address) values('ana', '47 st NW');

select * from companies;

/* 
! ALTER TABLE is used to alter/update a table
! When we create a new column if we don't set the NOT NULL it will be the
! default value, but if we set NOT NULL the default will be 0 for INT and 
! ' ' for VARCHAR. We can also set other default values using DEFAULT.
*/
 
ALTER TABLE companies
ADD COLUMN employee_count INT NOT NULL DEFAULT 1;

ALTER TABLE companies 
DROP COLUMN phone;

RENAME TABLE companies to suppliers;

ALTER TABLE suppliers 
RENAME TO companies;

ALTER TABLE companies
RENAME COLUMN name TO company_name;

ALTER TABLE companies
MODIFY company_name VARCHAR(100) DEFAULT 'unknown';

/* 
! Changing the name of the column and the value at the same time
*/
ALTER TABLE companies
CHANGE company_name business_name VARCHAR(50); 

ALTER TABLE contacts 
ADD CONSTRAINT phone_check CHECK (phone != 0);

ALTER TABLE contacts DROP CONSTRAINT phone_check;

