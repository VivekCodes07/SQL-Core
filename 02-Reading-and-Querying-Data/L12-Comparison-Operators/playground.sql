# L12 - Comparison Operators

-- ==========================================
-- 1. Create a New Database
-- ==========================================

-- I'm creating a separate database for my e-commerce
-- examples so that I don't mix them with my existing
-- school management database.

CREATE DATABASE IF NOT EXISTS ecommerce_learning;

-- Select the database in which I want to work.

USE ecommerce_learning;


-- ==========================================
-- 2. Create the Products Table
-- ==========================================

-- An e-commerce application needs to store information
-- about the products available in its store.
--
-- Each product will have:
-- product_id   : Unique ID of the product
-- product_name : Name of the product
-- category     : Category to which it belongs
-- price        : Selling price of the product
-- stock        : Available quantity in inventory

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);


-- ==========================================
-- 3. Insert Sample Product Records
-- ==========================================

-- I'm adding different products with different prices
-- and stock quantities so that I can practice
-- comparison operators using realistic data.
--
-- INSERT IGNORE prevents duplicate primary-key errors
-- if I execute this insertion section again.

INSERT IGNORE INTO products
    (product_id, product_name, category, price, stock)
VALUES
    (101, 'Keyboard', 'Accessories', 799.00, 15),
    (102, 'Mouse', 'Accessories', 499.00, 25),
    (103, 'Monitor', 'Electronics', 8999.00, 8),
    (104, 'Headphones', 'Electronics', 1499.00, 12),
    (105, 'USB Cable', 'Accessories', 199.00, 50),
    (106, 'Webcam', 'Electronics', 2499.00, 5);


-- ==========================================
-- 4. View All Product Records
-- ==========================================

-- Let's verify that our database and table
-- have been created and the records are inserted.

SELECT * FROM products;


-- ==========================================
-- 5. Equal To (=)
-- ==========================================

-- Find the product whose price is exactly 1499.

SELECT *
FROM products
WHERE price = 1499;


-- Find all products belonging to Electronics.

SELECT *
FROM products
WHERE category = 'Electronics';


-- ==========================================
-- 6. Not Equal To (!= and <>)
-- ==========================================

-- Find all products except the Mouse.

SELECT *
FROM products
WHERE product_name != 'Mouse';


-- Both operators perform the same operation.

SELECT *
FROM products
WHERE product_name <> 'Mouse';


-- ==========================================
-- 7. Greater Than (>)
-- ==========================================

-- Find products costing more than 1000.

SELECT *
FROM products
WHERE price > 1000;


-- Find products having more than 10 units in stock.

SELECT *
FROM products
WHERE stock > 10;


-- ==========================================
-- 8. Less Than (<)
-- ==========================================

-- Find products costing less than 500.

SELECT *
FROM products
WHERE price < 500;


-- Find products having less than 10 units in stock.

SELECT *
FROM products
WHERE stock < 10;


-- ==========================================
-- 9. Greater Than or Equal To (>=)
-- ==========================================

-- Find products with at least 10 units in stock.
-- Products with exactly 10 units should also be included.

SELECT *
FROM products
WHERE stock >= 10;


-- Find products costing 1499 or more.

SELECT *
FROM products
WHERE price >= 1499;


-- ==========================================
-- 10. Less Than or Equal To (<=)
-- ==========================================

-- Find products having 8 or fewer units in stock.

SELECT *
FROM products
WHERE stock <= 8;


-- Find products costing 499 or less.

SELECT *
FROM products
WHERE price <= 499;


-- ==========================================
-- 11. Combining Comparison and Logical Operators
-- ==========================================

-- Find products costing more than 1000
-- AND having at least 10 units in stock.

SELECT *
FROM products
WHERE price > 1000
AND stock >= 10;


-- Find products costing less than 500
-- OR having more than 20 units in stock.

SELECT *
FROM products
WHERE price < 500
OR stock > 20;


-- Find Electronics products costing more than 1000.

SELECT *
FROM products
WHERE category = 'Electronics'
AND price > 1000;


-- ==========================================
-- 12. Real-World Inventory Scenarios
-- ==========================================

-- Scenario 1:
-- Find products that need restocking.
-- For this example, consider 8 or fewer units
-- as low inventory.

SELECT *
FROM products
WHERE stock <= 8;


-- Scenario 2:
-- Find premium products costing at least 2000.

SELECT *
FROM products
WHERE price >= 2000;


-- Scenario 3:
-- Find affordable products costing between
-- the store's chosen maximum of 500 (exclusive).

SELECT *
FROM products
WHERE price < 500;


-- Scenario 4:
-- Find products that are not priced at 799.

SELECT *
FROM products
WHERE price != 799;


-- ==========================================
-- 13. Final Verification
-- ==========================================

-- Check the database currently selected.

SELECT DATABASE();

-- View the complete product inventory again.

SELECT * FROM products;

