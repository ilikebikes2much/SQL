CREATE TABLE public.titanic
(
	passengerid integer,
	survived integer,
	pclass integer,
	name character(225) ,
	sex character(30),
	age numeric,
	sibsp integer,
	parch integer,
	ticket character(30),
	fare money,
	cabin character(15),
	embarked character(1)
);

-- LOAD DATA INTO A TABLE
COPY titanic FROM 'C:\Users\Matthew\Desktop\DataScience\titanic.csv' DELIMITER ',' CSV HEADER;


-- ALTER SYNTAX:

-- Add column(s): 
ALTER TABLE titanic 
ADD test integer,
ADD	test2 character(30);


-- Drop column: 
ALTER TABLE titanic DROP COLUMN test2;


-- Rename column: 
ALTER TABLE titanic RENAME COLUMN test TO delete;

-- Rename table: 
ALTER TABLE titanic RENAME TO titanic02;


/* The SQL DROP TABLE statement is used to remove a table definition and all data, indexes, triggers,
constraints, and permission specifications for that table. 
NOTE: You have to be careful while using this command, because once a table is deleted, 
all the information available in the table will also be lost forever. */

DROP TABLE titanic03

CREATE TABLE public.titanic03 (
  	pclass integer,
	sex character(30),
    age integer,
    survived integer)

/* INSERT INTO  will extract data from a source table and transfer it to a target table. */

INSERT INTO titanic03 SELECT pclass, sex, age, survived FROM titanic02


