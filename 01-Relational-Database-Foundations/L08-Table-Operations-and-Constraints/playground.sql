SHOW DATABASES;

CREATE DATABASE microsoft;

USE microsoft;

CREATE TABLE employees (
    -- PRIMARY KEY: Uniquely identifies each row (cannot be NULL)
    -- AUTO_INCREMENT: Automatically generates a new sequential ID for new rows
    employee_id INT PRIMARY KEY AUTO_INCREMENT, 
    
    -- NOT NULL: Prevents missing or blank values
    first_name VARCHAR(50) NOT NULL,
    
    -- NOT NULL: Prevents missing or blank values
    last_name VARCHAR(50) NOT NULL,
    
    -- DEFAULT: Falls back to a specific value (today's date) if no input is given
    hired_date DATE DEFAULT (CURDATE()),
    
    -- UNIQUE: Ensures no two rows can have the same value in this column
    email VARCHAR(100) UNIQUE,
    
    -- CHECK: Validates custom logic; rejects entry if data violates the rule
    salary DECIMAL(10, 2) CHECK (salary > 0),
    
    -- ENUM: Limits inputs strictly to a predefined list of allowed string choices
    employee_status ENUM('Active', 'On leave', 'Terminated') DEFAULT 'Active',
    
    -- DEFAULT CURRENT_TIMESTAMP: Auto-logs the system date/time upon row creation
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- ON UPDATE: Auto-updates to the current system date/time when a row is edited
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE employees;

-- Only specify the required columns. employee_id will auto-increment to 1, and hired_date/timestamps will fill automatically.
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('Michael', 'Jackson', 'michael.j@email.com', 5000000.00);

INSERT INTO employees (
    employee_id,
    first_name,
    last_name,
    hired_date,
    email,
    salary,
    employee_status
)
VALUES (
    2, 
    'John', 
    'Cena', 
    '2026-10-16', 
    'john.cena@email.com', 
    7500.00, 
    'Active'
);


SELECT * FROM employees;

-- Here, Unique: Prevents two employees for having the same phone number.
-- And AFTER email: Places the new column logically next to the email field for clean table organization.

-- 1. Positioning Columns
ALTER TABLE employees
ADD COLUMN phone_number VARCHAR(15) UNIQUE AFTER email;

-- Update Michael Jackson
UPDATE employees
SET phone_number = '+91 9988998855'
WHERE employee_id = 1;

-- Update John Cena
UPDATE employees 
SET phone_number = '+91 6201766193'
WHERE employee_id = 2;

-- I'll study about updation in detail in next lessons


-- 2. Adding Columns
ALTER TABLE employees
ADD COLUMN description TEXT;

-- 3. MODIFY COLUMN -> when you want to change the data type or the rules (constraints) of a column, but keep its name the same.
ALTER TABLE employees 
MODIFY COLUMN description VARCHAR(1000) DEFAULT 'No description available';
 
-- 4. RENAME COLUMN -> when you want to change only the name of the column, leaving the data type completely alone.
ALTER TABLE employees 
RENAME COLUMN description TO employee_bio;

-- 5. DROP COLUMN
ALTER TABLE employees
DROP COLUMN employee_bio;



CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO departments (department_id, department_name, location) VALUES 
(1, 'Computer Science & Engineering', 'Block A, Tech Pavilion'),
(2, 'Mechanical Engineering', 'Block C, Workshop Complex'),
(3, 'Business Administration', 'Management Wing, 2nd Floor'),
(4, 'Basic Sciences & Humanities', 'Science Lab Block'),
(5, 'Admissions & Student Affairs', 'Administrative Main Building'),
(6, 'Training & Placement Cell', 'Placement Hub, Library Block');

SELECT * FROM employees;
SELECT * FROM departments;

-- I am adding a department_id column here and making it NOT NULL so every employee must have a department
ALTER TABLE employees
ADD COLUMN department_id INT NOT NULL;

-- I am linking department_id to the departments table so it only accepts real, existing department IDs
ALTER TABLE employees 
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);


UPDATE employees 
SET department_id = 1
WHERE employee_id = 1;

UPDATE employees 
SET department_id = 3
WHERE employee_id = 2;

-- I am inserting just one more employee record that matches all our rules and links to the IT department
INSERT INTO employees (
        first_name,
        last_name,
        email,
        phone_number,
        salary,
        employee_status,
        department_id
    )
VALUES (
        'David',
        'Miller',
        'david.miller@email.com',
        '+91 9911223344',
        65000.00,
        'Active',
        1
    );

SELECT * FROM employees;