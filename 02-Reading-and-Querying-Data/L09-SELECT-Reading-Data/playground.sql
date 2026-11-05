/*
    L09 - SELECT (Reading Data)
    
    In this lesson, I'm learning how to retrieve information
    from database tables using the SELECT statement.

    I'll use a students table from my School Management System
    to understand how SELECT works in different situations.
*/


-- ============================================
-- 1. SETTING UP THE DATABASE
-- ============================================

-- First, I'm selecting the database in which I want to work.
USE sql_learning;


-- ============================================
-- 2. CREATING A SAMPLE TABLE
-- ============================================

-- I'm creating a students table to practise SELECT queries.
-- If the table already exists, this command removes it
-- before creating a fresh one for this lesson.

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50),
    city VARCHAR(50)
);


-- ============================================
-- 3. INSERTING SAMPLE RECORDS
-- ============================================

-- Before reading data, I need some records in my table.
-- INSERT adds these sample student records.

INSERT INTO students (name, age, course, city)
VALUES
    ('John', 20, 'CSE', 'Delhi'),
    ('Roman', 21, 'IT', 'Mumbai'),
    ('Seth', 19, 'CSE', 'Chandigarh'),
    ('Randy', 22, 'ECE', 'Pune'),
    ('Brock', 20, 'Mechanical', 'Jaipur');


-- ============================================
-- 4. VIEWING ALL COLUMNS
-- ============================================

-- SELECT is used to retrieve data from a table.
-- The asterisk (*) tells MySQL that I want every column.

SELECT *
FROM students;


-- ============================================
-- 5. RETRIEVING A SINGLE COLUMN
-- ============================================

-- What if I only need the names of all students?
-- Instead of retrieving every column, I can mention
-- the exact column I want.

SELECT name
FROM students;


-- ============================================
-- 6. RETRIEVING MULTIPLE COLUMNS
-- ============================================

-- I can retrieve more than one column by separating
-- their names with commas.

SELECT name, age
FROM students;


-- ============================================
-- 7. CHANGING THE COLUMN ORDER
-- ============================================

-- The order in which I mention columns determines
-- their order in the returned result.

SELECT course, name
FROM students;


-- ============================================
-- 8. RETRIEVING THREE SPECIFIC COLUMNS
-- ============================================

-- Here, I only want the student's ID, name, and course.
-- The remaining columns won't appear in this result.

SELECT student_id, name, course
FROM students;


-- ============================================
-- 9. UNDERSTANDING THE ORIGINAL TABLE
-- ============================================

-- Running SELECT does not modify or delete any records.
-- I'm retrieving the complete table again to see that
-- all the original data is still present.

SELECT *
FROM students;


-- ============================================
-- 10. MY OWN PRACTICE
-- ============================================

-- Try writing these queries yourself:
--
-- 1. Retrieve all student records.
-- 2. Retrieve only the age column.
-- 3. Retrieve student names and cities.
-- 4. Retrieve student IDs, names, and ages.
-- 5. Retrieve course first, followed by city and name.
--
-- Write your queries below.

-- 1. Retrieving all student records.
SELECT *
FROM students;

-- 2. Retrieving only the age column.
SELECT age
FROM students;

-- 3. Retrieving student names and cities.
SELECT name, city
FROM students;

-- 4. Retrieving IDs, names, and ages.
SELECT student_id, name, city
FROM students;

-- 5. Retrieving course first followed by city and name.
SELECT course, city, name
FROM students;

-- ============================================
-- COLUMN ALIASES USING AS
-- ============================================

-- AS gives a temporary heading to a column
-- in the query result. It doesn't rename the
-- actual column in the database.

SELECT name AS student_name
FROM students;

-- I can also assign aliases to multiple columns.

SELECT
    student_id AS id,
    name AS student_name,
    course AS enrolled_course
FROM students;