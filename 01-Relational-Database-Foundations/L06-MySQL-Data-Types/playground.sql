-- Lesson 06: MySQL Data Types
-- Goal: Understand how MySQL stores different kinds of values.

-- Select the database I want to use for this lesson.
CREATE DATABASE IF NOT EXISTS sql_learning;
USE sql_learning;


-- 1. Create a table to experiment with different data types.
-- I am using a separate table so I don't disturb my earlier lessons.

CREATE TABLE IF NOT EXISTS datatype_practice (
    id INT,
    name VARCHAR(100),
    country_code CHAR(2),
    age TINYINT UNSIGNED,
    percentage DECIMAL(5,2),
    scientific_value DOUBLE,
    date_of_birth DATE,
    class_start_time TIME,
    registered_at DATETIME,
    is_active BOOLEAN,
    preferences JSON
);


-- 2. Inspect the table structure before inserting data.
-- I want to see the column names and the types I selected.

DESCRIBE datatype_practice;


-- 3. Insert sample values.
-- The names are fictional practice data.
-- These INSERT statements are intended to run only once.

INSERT INTO datatype_practice (
    id,
    name,
    country_code,
    age,
    percentage,
    scientific_value,
    date_of_birth,
    class_start_time,
    registered_at,
    is_active,
    preferences
)
VALUES
(
    1,
    'John Cena',
    'IN',
    21,
    87.50,
    3.1415926535,
    '2005-04-23',
    '09:30:00',
    '2026-10-14 09:00:00',
    TRUE,
    '{"theme": "dark", "notifications": true}'
),
(
    2,
    'Roman Reigns',
    'US',
    22,
    91.25,
    2.7182818284,
    '2004-08-15',
    '10:00:00',
    '2026-10-14 09:15:00',
    TRUE,
    '{"theme": "light", "notifications": false}'
),
(
    3,
    'Cody Rhodes',
    'GB',
    20,
    76.80,
    1.4142135623,
    '2006-06-30',
    '11:00:00',
    '2026-10-14 09:30:00',
    FALSE,
    '{"theme": "dark", "notifications": true}'
);


-- 4. Read the complete table.
-- I want to see the values MySQL stored for each column.

SELECT * FROM datatype_practice;


-- 5. Inspect selected columns.
-- This makes it easier to focus on the different numeric types.

SELECT
    id,
    name,
    age,
    percentage,
    scientific_value
FROM datatype_practice;


-- 6. Compare exact decimal values and approximate floating-point values.
-- DECIMAL is suitable for exact decimal values.
-- DOUBLE is designed for approximate floating-point calculations.

SELECT
    name,
    percentage,
    scientific_value
FROM datatype_practice;


-- 7. Inspect the date and time values separately.

SELECT
    name,
    date_of_birth,
    class_start_time,
    registered_at
FROM datatype_practice;


-- 8. See how MySQL represents BOOLEAN values.
-- In MySQL, TRUE is represented as 1 and FALSE as 0.

SELECT
    name,
    is_active
FROM datatype_practice;


-- 9. Read a value from a JSON document.
-- JSON_EXTRACT reads the theme property from preferences.

SELECT
    name,
    JSON_EXTRACT(preferences, '$.theme') AS theme
FROM datatype_practice;


-- 10. Experiment with the table structure.
-- Uncomment this command if I want to inspect the complete definition.
-- SHOW CREATE TABLE datatype_practice;


-- 11. Experiment with an invalid value.
-- Uncomment this statement and execute it separately.
-- The age column is TINYINT UNSIGNED, so -5 is outside its valid range.
-- INSERT INTO datatype_practice (id, name, age)
-- VALUES (4, 'Test Student', -5);


-- 12. Experiment with the maximum length of VARCHAR.
-- The name column allows up to 100 characters.
-- Try inserting a longer value in strict SQL mode to observe the error.
-- Do not run this statement unless I am intentionally testing the limit.
-- INSERT INTO datatype_practice (id, name)
-- VALUES (4, REPEAT('A', 101));


-- 13. Check the table again after my experiments.

SELECT * FROM datatype_practice;