# L11 - Logical Operators

USE sql_learning;


-- ==========================================
-- 1. Check Existing Student Records
-- ==========================================

-- Let's first see the records we will be working with.

SELECT *
FROM students;


-- ==========================================
-- 2. AND Operator
-- ==========================================

-- AND returns records only when ALL conditions are true.

-- Scenario 1:
-- Find students who are enrolled in CSE
-- AND live in Delhi.

SELECT *
FROM students
WHERE course = 'CSE'
AND city = 'Delhi';

-- Expected result: John


-- Scenario 2:
-- Find students who are 20 years old
-- AND enrolled in CSE.

SELECT *
FROM students
WHERE age = 20
AND course = 'CSE';

-- Expected result: John


-- Scenario 3:
-- Find students who live in Mumbai
-- AND are enrolled in IT.

SELECT *
FROM students
WHERE city = 'Mumbai'
AND course = 'IT';

-- Expected result: Roman


-- ==========================================
-- 3. OR Operator
-- ==========================================

-- OR returns records when AT LEAST ONE condition is true.

-- Scenario 1:
-- Find students enrolled in either CSE or IT.

SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT';

-- Expected result: John, Roman, Seth


-- Scenario 2:
-- Find students who live in either Delhi or Mumbai.

SELECT *
FROM students
WHERE city = 'Delhi'
OR city = 'Mumbai';

-- Expected result: John, Roman


-- Scenario 3:
-- Find students whose name is either John or Brock.

SELECT *
FROM students
WHERE name = 'John'
OR name = 'Brock';

-- Expected result: John, Brock


-- ==========================================
-- 4. NOT Operator
-- ==========================================

-- NOT reverses the result of a condition.

-- Scenario 1:
-- Find students who are NOT enrolled in CSE.

SELECT *
FROM students
WHERE NOT (course = 'CSE');

-- Expected result: Roman, Randy, Brock


-- Scenario 2:
-- Find students who do NOT live in Delhi.

SELECT *
FROM students
WHERE NOT (city = 'Delhi');

-- Expected result: Roman, Seth, Randy, Brock


-- ==========================================
-- 5. Combining AND and OR
-- ==========================================

-- We can combine multiple logical operators
-- to create more specific filtering conditions.

-- Scenario 1:
-- Find students who are enrolled in CSE or IT
-- AND live in Delhi.

SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'IT')
AND city = 'Delhi';

-- Expected result: John


-- Scenario 2:
-- Find students who live in Delhi or Mumbai
-- AND are 20 years old.

SELECT *
FROM students
WHERE (city = 'Delhi' OR city = 'Mumbai')
AND age = 20;

-- Expected result: John


-- ==========================================
-- 6. Understanding Operator Precedence
-- ==========================================

-- MySQL evaluates AND before OR.
-- Let's understand why parentheses matter.

-- Without parentheses:

SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT'
AND city = 'Delhi';

-- MySQL interprets this as:
-- course = 'CSE' OR (course = 'IT' AND city = 'Delhi')
--
-- Expected result: John, Seth


-- With parentheses:

SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'IT')
AND city = 'Delhi';

-- Now both course conditions are grouped together.
-- Expected result: John


-- Notice how the same conditions can produce
-- different results depending on their grouping.


-- ==========================================
-- 7. Combining NOT with AND and OR
-- ==========================================

-- NOT can also be combined with other logical operators.

-- Scenario 1:
-- Find students who are NOT enrolled in CSE
-- AND do not live in Delhi.

SELECT *
FROM students
WHERE NOT (course = 'CSE')
AND NOT (city = 'Delhi');

-- Expected result: Roman, Randy, Brock


-- Scenario 2:
-- Find students who are enrolled in either CSE or IT,
-- but NOT older than 20.

SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'IT')
AND NOT (age > 20);

-- Expected result: John, Seth


-- ==========================================
-- 8. Understanding NULL with Logical Operators
-- ==========================================

-- In L10, I learned that NULL represents missing
-- or unknown data.
--
-- MySQL can produce three logical results:
-- TRUE, FALSE, and UNKNOWN.
--
-- Let's use our existing contact demo table
-- from L10 to understand this behaviour.

-- Scenario 1:
-- Find students whose phone number is not
-- equal to John's phone number.

SELECT *
FROM student_contact_demo
WHERE NOT (phone = '9876543210');

-- Expected result: Seth
--
-- Why isn't Roman returned?
-- Roman's phone is NULL, so MySQL cannot determine
-- whether it is equal to John's phone number.
-- The comparison produces UNKNOWN.
-- NOT UNKNOWN is still UNKNOWN, so Roman is excluded.


-- Scenario 2:
-- Find students whose phone number is missing
-- OR whose name is John.

SELECT *
FROM student_contact_demo
WHERE phone IS NULL
OR name = 'John';

-- Expected result: John, Roman, Randy


-- Scenario 3:
-- Find students whose phone number exists
-- AND whose name is not John.

SELECT *
FROM student_contact_demo
WHERE phone IS NOT NULL
AND NOT (name = 'John');

-- Expected result: Seth, Brock


-- ==========================================
-- 9. Real-World Backend Scenarios
-- ==========================================

-- Scenario 1:
-- A student portal wants to display students
-- enrolled in CSE or IT who live in Mumbai.

SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'IT')
AND city = 'Mumbai';

-- Expected result: Roman


-- Scenario 2:
-- Find students who are not enrolled in CSE
-- AND do not live in Delhi.

SELECT *
FROM students
WHERE NOT (course = 'CSE')
AND NOT (city = 'Delhi');

-- Expected result: Roman, Randy, Brock


-- Scenario 3:
-- Find students whose name is John or Roman
-- and who are 20 years old.

SELECT *
FROM students
WHERE (name = 'John' OR name = 'Roman')
AND age = 20;

-- Expected result: John


-- Scenario 4:
-- An e-commerce application wants products
-- that belong to Electronics or Accessories
-- AND have stock available.
--
-- This example assumes the products table
-- from our L12 ecommerce_learning database.

USE ecommerce_learning;

SELECT *
FROM products
WHERE (category = 'Electronics' OR category = 'Accessories')
AND stock > 0;


-- Return to our original learning database.

USE sql_learning;