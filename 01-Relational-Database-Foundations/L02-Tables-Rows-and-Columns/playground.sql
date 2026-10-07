-- Lesson 02: Tables, Rows and Columns

USE sql_learning;


-- Create a table

CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(255)
);


-- Insert data

INSERT INTO students (id, name, age, email)
VALUES
    (1, 'Vivek', 20, 'vivek@example.com'),
    (2, 'Rahul', 21, 'rahul@example.com'),
    (3, 'Aman', 19, 'aman@example.com');


-- See all tables

SHOW TABLES;


-- See table structure

DESC students;


-- Insert more students

INSERT INTO students (id, name, age, email)
VALUES
    (4, 'Anas', 20, 'anas@example.com'),
    (5, 'Neha', 22, 'neha@example.com');


-- See the data

SELECT *
FROM students;


-- Create another table

CREATE TABLE courses (
    id INT,
    name VARCHAR(100),
    duration INT
);


-- Insert courses

INSERT INTO courses (id, name, duration)
VALUES
    (1, 'Java', 6),
    (2, 'SQL', 4),
    (3, 'MongoDB', 3);


-- See tables again

SHOW TABLES;


-- See courses structure

DESC courses;


-- See course data

SELECT *
FROM courses;
