# L10 - WHERE and Filtering

USE sql_learning;

-- ==========================================
-- 1. Check the Existing Student Records
-- ==========================================

-- Before filtering data, let's see all the records
-- currently available in our students table.

SELECT * FROM students;


-- ==========================================
-- 2. Understanding the WHERE Clause
-- ==========================================

-- Imagine our student portal has hundreds of records.
-- If we only want to find students enrolled in CSE,
-- displaying every student would be unnecessary.

-- WHERE helps us retrieve only the records
-- that satisfy a particular condition.

SELECT *
FROM students
WHERE course = 'CSE';


-- ==========================================
-- 3. Filtering Using Text Values
-- ==========================================

-- Text values must be enclosed in single quotes.
-- Here, we are retrieving students from Mumbai.

SELECT *
FROM students
WHERE city = 'Mumbai';


-- We can also search for a student by name.

SELECT *
FROM students
WHERE name = 'Brock';


-- ==========================================
-- 4. Filtering Using Numeric Values
-- ==========================================

-- Numeric values do not require quotation marks.
-- Here, we are finding the student whose ID is 5.

SELECT *
FROM students
WHERE student_id = 5;


-- We can also retrieve students of a particular age.

SELECT *
FROM students
WHERE age = 20;


-- ==========================================
-- 5. Selecting Specific Columns with WHERE
-- ==========================================

-- WHERE decides which rows we want.
-- SELECT decides which columns we want to display.

-- Here, we only need the names of students
-- who are enrolled in CSE.

SELECT name
FROM students
WHERE course = 'CSE';


-- We can retrieve multiple columns as well.

SELECT name, age, city
FROM students
WHERE course = 'CSE';


-- ==========================================
-- 6. Understanding What WHERE Returns
-- ==========================================

-- Let's retrieve Roman's complete record.

SELECT *
FROM students
WHERE name = 'Roman';

-- The database checks the condition for each row
-- and returns only the matching record.


-- ==========================================
-- 7. Handling NULL Values
-- ==========================================

-- NULL represents missing or unknown data.
-- It is different from an empty string ('') or zero (0).

-- Our existing students table doesn't have a phone column.
-- So, let's create a separate table to practise NULL values
-- without changing our original students table.

CREATE TABLE IF NOT EXISTS student_contact_demo (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20)
);

INSERT IGNORE INTO student_contact_demo
    (student_id, name, phone)
VALUES
    (1, 'John', '9876543210'),
    (2, 'Roman', NULL),
    (3, 'Seth', '9123456780'),
    (4, 'Randy', NULL),
    (5, 'Brock', '9988776655');


-- IS NULL finds records where the phone number is missing.

SELECT *
FROM student_contact_demo
WHERE phone IS NULL;


-- IS NOT NULL finds records where a phone number exists.

SELECT *
FROM student_contact_demo
WHERE phone IS NOT NULL;


-- Important:
-- We cannot use phone = NULL to check for missing values.
-- SQL uses IS NULL and IS NOT NULL for this purpose.


-- ==========================================
-- 8. Pattern Matching Using LIKE
-- ==========================================

-- Sometimes we don't know the complete value we are
-- searching for. For example, we may only know that
-- a student's name starts with the letter 'R'.

-- LIKE helps us search for values using patterns.

-- Two important wildcards are:
--
-- % represents zero or more characters.
-- _ represents exactly one character.


-- Find students whose names start with 'R'.

SELECT *
FROM students
WHERE name LIKE 'R%';


-- Find students whose names end with 'n'.

SELECT *
FROM students
WHERE name LIKE '%n';


-- Find students whose names contain 'an'.

SELECT *
FROM students
WHERE name LIKE '%an%';


-- Find students whose names have exactly four characters.
-- Each underscore represents one character.

SELECT *
FROM students
WHERE name LIKE '____';


-- NOT LIKE returns records that do not match the pattern.

SELECT *
FROM students
WHERE name NOT LIKE 'R%';


-- Note:
-- Whether LIKE is case-sensitive depends on the
-- collation used by the column or database.


-- ==========================================
-- 9. Filtering Multiple Values Using IN
-- ==========================================

-- Imagine we want students enrolled in either CSE or IT.
-- We could write multiple conditions using OR.

SELECT *
FROM students
WHERE course = 'CSE' OR course = 'IT';


-- But when we need to check multiple possible values,
-- IN makes the condition shorter and easier to read.

SELECT *
FROM students
WHERE course IN ('CSE', 'IT');


-- IN checks whether a column matches any value
-- from the list provided inside the parentheses.


-- NOT IN does the opposite.
-- It returns records whose course is not in the given list.

SELECT *
FROM students
WHERE course NOT IN ('CSE', 'IT');


-- Important:
-- Avoid placing NULL inside a NOT IN list.
-- NULL can make the condition evaluate to UNKNOWN,
-- which may prevent the expected records from appearing.


-- ==========================================
-- 10. Practice: Real-World Scenarios
-- ==========================================

-- Scenario 1:
-- Find all students enrolled in IT.

SELECT *
FROM students
WHERE course = 'IT';


-- Scenario 2:
-- Find the student living in Chandigarh.

SELECT *
FROM students
WHERE city = 'Chandigarh';


-- Scenario 3:
-- Display only the names of students aged 20.

SELECT name
FROM students
WHERE age = 20;


-- Scenario 4:
-- Find the student with student ID 3.

SELECT *
FROM students
WHERE student_id = 3;


-- Scenario 5:
-- Find students whose names start with 'S'.

SELECT *
FROM students
WHERE name LIKE 'S%';


-- Scenario 6:
-- Find students enrolled in CSE or ECE.

SELECT *
FROM students
WHERE course IN ('CSE', 'ECE');


-- Scenario 7:
-- Find students whose phone numbers are missing.

SELECT *
FROM student_contact_demo
WHERE phone IS NULL;


-- Scenario 8:
-- Find students whose names do not start with 'R'.

SELECT *
FROM students
WHERE name NOT LIKE 'R%';