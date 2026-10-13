-- Lesson 03: SQL Command Categories
-- Goal: Understand what different SQL commands do by running them.

-- DDL: Data Definition Language
-- DDL is used to define or change database structure.

CREATE DATABASE IF NOT EXISTS sql_learning;

USE sql_learning;

CREATE TABLE IF NOT EXISTS students (
    id INT,
    name VARCHAR(100),
    age INT
);

-- Check the structure of the table I created.
DESCRIBE students;


-- DML: Data Manipulation Language
-- DML is used to add, change or remove records.

-- Add some sample student records.
-- The names are examples; the ages are fictional practice data.
INSERT INTO students (id, name, age)
VALUES
    (1, 'John Cena', 21),
    (2, 'Roman Reigns', 20),
    (3, 'Cody Rhodes', 22);

-- Change the age of one student.
UPDATE students
SET age = 23
WHERE id = 3;

-- View the records after the update.
SELECT * FROM students;


-- DQL: Data Query Language
-- DQL is used to retrieve stored information.

-- Retrieve all columns and records.
SELECT * FROM students;

-- Retrieve only the names and ages.
SELECT name, age
FROM students;


-- DML: Removing a record
-- DELETE removes matching records but keeps the table itself.
-- This example removes only the student whose ID is 2.

DELETE FROM students
WHERE id = 2;

-- Check which records remain.
SELECT * FROM students;


-- DDL: Changing table structure
-- Add a new column to the existing table.

ALTER TABLE students
ADD email VARCHAR(150);

-- Check the updated table structure.
DESCRIBE students;


-- DDL: Removing a table
-- DROP TABLE removes the table and its records.
-- I am keeping this command commented out to protect my practice data.

-- DROP TABLE students;


-- DCL: Data Control Language
-- GRANT and REVOKE manage database permissions.
-- These commands are not executed here because they require
-- appropriate MySQL users and privileges.

-- GRANT SELECT ON sql_learning.students TO 'teacher_user'@'localhost';
-- REVOKE SELECT ON sql_learning.students FROM 'teacher_user'@'localhost';


-- TCL: Transaction Control Language
-- Transactions help group related changes together.
-- This example requires a transactional storage engine such as InnoDB.

CREATE TABLE IF NOT EXISTS transaction_demo (
    id INT PRIMARY KEY,
    balance DECIMAL(10, 2)
) ENGINE = InnoDB;

-- Add the initial records only if the table is empty.
INSERT INTO transaction_demo (id, balance)
SELECT 1, 5000.00
WHERE NOT EXISTS (
    SELECT 1 FROM transaction_demo WHERE id = 1
);

INSERT INTO transaction_demo (id, balance)
SELECT 2, 3000.00
WHERE NOT EXISTS (
    SELECT 1 FROM transaction_demo WHERE id = 2
);

-- View the balances before the transaction.
SELECT * FROM transaction_demo;

-- Start a transaction and make two related changes.
START TRANSACTION;

UPDATE transaction_demo
SET balance = balance - 1000.00
WHERE id = 1;

UPDATE transaction_demo
SET balance = balance + 1000.00
WHERE id = 2;

-- Make both changes permanent.
COMMIT;

-- Check the balances after the transaction.
SELECT * FROM transaction_demo;