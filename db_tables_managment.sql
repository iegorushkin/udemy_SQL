/* Let's start with the common simple syntax for creating an table */
CREATE TABLE account (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_name TEXT UNIQUE NOT NULL,
	email TEXT UNIQUE NOT NULL,
	password TEXT NOT NULL,
	last_login DATETIME,
	created_on DATETIME NOT NULL
);

CREATE TABLE job (
	job_id INTEGER PRIMARY KEY AUTOINCREMENT,
	job_name TEXT UNIQUE NOT NULL
);

CREATE TABLE account_job (
	 user_id INTEGER REFERENCES account(user_id),
	 job_id INTEGER REFERENCES job(job_id),
	 hire_date DATETIME NOT NULL
);

/* ChatGPT version of the intermediate table 
It's reasoning: "While your original variant is correct and should work,
adding these constraints can help maintain data integrity and improve
the performance and clarity of your database schema." */
CREATE TABLE account_job (
    user_id INTEGER NOT NULL,
    job_id INTEGER NOT NULL,
    hire_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES account(user_id),
    FOREIGN KEY (job_id) REFERENCES job(job_id),
    PRIMARY KEY (user_id, job_id)
);

/* Insert command. */
--
INSERT INTO account (user_name, email, password, created_on)
VALUES ('Jose', 'jose@gmail.com', 'password', CURRENT_TIMESTAMP);

SELECT *
FROM account;
--
INSERT INTO job(job_name)
VALUES ('Astronaut');

SELECT *
FROM job;
--
INSERT INTO account_job (user_id, job_id, hire_date)
VALUES 
	(1, 1, CURRENT_TIMESTAMP);
	
SELECT *
FROM account_job;
-- What if required user_id and job_id doesn't exist?
INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
	(10, 10, datetime('1974-10-24'));
-- ERROR!

/* Update table */
UPDATE account
SET last_login = created_on;

SELECT *
FROM account;
-- So-called update JOIN 
UPDATE account_job 
--             maybe not really needed
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

SELECT *
FROM account_job;
SELECT *
FROM account;
-- RETURNING doesn't exist in SQLite
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login

/* DELETE clause */
-- Add a row
INSERT INTO job(job_name)
VALUES ('Cowboy');
-- Check the table
SELECT *
FROM job;
-- Delete a row
DELETE FROM job
WHERE job_name = 'Cowboy';
-- Check the table
SELECT *
FROM job;

/* ALTER table.  */
-- Set up a table
CREATE TABLE information (
	info_id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT NOT NULL,
	person TEXT NOT NULL UNIQUE
);
-- Rename it
ALTER TABLE information
RENAME TO new_info;
-- Rename a column of this table
ALTER TABLE new_info
RENAME COLUMN person TO people;
-- Insert new data
-- Incorrectly!
INSERT INTO new_info(title)
 --> Error! NOT NULL constraint failed: new_info.people
VALUES ('new test title');
--Kill the constraint on people and add the same value in title
-- This doesn't work in SQLite. 
ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;
-- Instead, a new table should be created
-- 1. Create the Original Table
CREATE TABLE new_info (
    info_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    person TEXT NOT NULL UNIQUE
);
-- 2. Create a New Table with the Desired Schema
CREATE TABLE new_info_temp (
    info_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    person TEXT UNIQUE  -- Dropped the NOT NULL constraint
);
-- 3. Copy Data from the Original Table to the New Table
INSERT INTO new_info_temp (info_id, title, person)
SELECT info_id, title, person
FROM new_info;
-- 4. Drop the Old Table
DROP TABLE new_info;
-- 5. Rename the New Table to the Original Table's Name
ALTER TABLE new_info_temp RENAME TO new_info;

/* Drop table / column */ 
DROP TABLE new_info;
-- Create new test table
CREATE TABLE new_info (
    info_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    person TEXT  -- Dropped the NOT NULL and UNIQUE constraints
);
-- Insert some data
INSERT INTO new_info(title)
VALUES ('new test title');
-- Drop a column
ALTER TABLE new_info
DROP COLUMN person;
-- Check the result
SELECT *
FROM new_info;
-- Try to drop the same column, but with a condition (PostgreSQL)
ALTER TABLE new_info
DROP COLUMN IF EXISTS person;

/* CHECK CONSTRAINT */
CREATE TABLE employees (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	birth_date DATE CHECK (birth_date > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birth_date),
	salary REAL CHECK (salary > 0)
);

INSERT INTO employees (
	first_name, last_name, birth_date, hire_date, salary
)
VALUES (
	'Igor', 'Egorushkin', '1992-12-09', '2010-01-01', 100
);

INSERT INTO employees (
	first_name, last_name, birth_date, hire_date, salary
)
VALUES (
	'Sammy', 'Smith', '1992-12-09', '2015-12-05', 69
);

SELECT *
FROM employees;































