-- Lesson 07: Database Commands
-- Goal: Practise creating, viewing, selecting, and checking databases.

-- 1. Creating a database
CREATE DATABASE IF NOT EXISTS school_db;

-- 2. Viewing all available databases
SHOW DATABASES;

-- 3. Switching to school_db
USE school_db;

-- 4. Checking the currently selected database
SELECT DATABASE();

-- 5. Creating another database for practice
CREATE DATABASE IF NOT EXISTS ecommerce_app;

-- 6. Verifying that the new database exists
SHOW DATABASES;

-- 7. Switching to ecommerce_app
USE ecommerce_app;

-- 8. Checking the currently selected database again
SELECT DATABASE();

-- 9. Switching back to school_db
USE school_db;

-- 10. Confirming the final database selection
SELECT DATABASE();

-- 11. Optional: Delete a database only when you are sure
-- DROP DATABASE ecommerce_app