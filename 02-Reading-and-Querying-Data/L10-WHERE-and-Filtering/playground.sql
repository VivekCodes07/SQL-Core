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
-- 7. Practice: Real-World Scenarios
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
