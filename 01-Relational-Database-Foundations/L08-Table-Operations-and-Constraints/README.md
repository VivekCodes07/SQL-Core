# Lesson 08 — Table Operations and Constraints

## Why Am I Learning This?

Until now, I've learned about databases, tables, rows, columns, keys, and relationships. I understand how relational databases organise information.

But knowing how a database works theoretically isn't enough.

Imagine I'm building a School Management System. I need to create a `students` table, insert student records, update their information, modify the table structure, and remove records when necessary.

But there's another problem.

What if someone accidentally inserts a student without a name? What if two students receive the same university email? What if an attendance record refers to a student who doesn't even exist?

I don't want my database to accept incorrect or inconsistent information.

This is where **Table Operations and Constraints** become important.

Table operations allow me to create and manage tables and their data, while constraints allow me to define rules that protect the accuracy and consistency of that data.

By the end of this lesson, I want to be comfortable creating and managing tables and enforcing rules on the data stored inside them.

## What Am I Going to Study?

I'll learn these concepts in a practical progression, using a School Management System as our running example.

### 1. Creating and Managing Tables

- `CREATE TABLE` — Creating a new table.
- Understanding table definitions and column declarations.
- `ALTER TABLE` — Modifying an existing table.
- Adding, modifying, and dropping columns.
- Renaming tables and columns.
- `DROP TABLE` — Permanently removing a table.
- `TRUNCATE TABLE` — Removing all records while keeping the table structure.

### 2. Working with Table Data

- `INSERT INTO` — Inserting new records.
- `UPDATE` — Modifying existing records.
- `DELETE` — Removing selected records.
- Understanding the difference between `DELETE`, `TRUNCATE`, and `DROP`.

### 3. Understanding Database Constraints

- What are constraints, and why do we need them?
- `NOT NULL` — Preventing missing values.
- `UNIQUE` — Preventing duplicate values.
- `PRIMARY KEY` — Uniquely identifying records.
- `FOREIGN KEY` — Establishing relationships between tables.
- `DEFAULT` — Assigning default values.
- `CHECK` — Enforcing conditions on column values.

### 4. Understanding Constraints in Practice

- Applying multiple constraints to a table.
- Understanding column-level and table-level constraints.
- Understanding how constraints prevent invalid data.
- Practising constraints using related tables.

### 5. Putting Everything Together

- Build a small School Management database.
- Create related tables.
- Insert records.
- Modify table structures.
- Apply appropriate constraints.
- Experiment with valid and invalid data.
- Understand the errors MySQL produces when a constraint is violated.

---

# Part 1 — Creating and Managing Tables

## 1. Understanding CREATE TABLE

Before inserting information into a database, I need somewhere to store it.

Imagine I want to store information about students in my school management application.

First, I'll create a table called `students`.

```sql
CREATE TABLE students (
    student_id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);
```

Let's understand what is happening here.

- `CREATE TABLE` tells MySQL that I want to create a new table.
- `students` is the name of my table.
- `student_id`, `name`, `age`, and `course` are column names.
- `INT` and `VARCHAR` define the types of values those columns can store.

Notice that I'm defining the structure of the table, not inserting any student records yet.

**Important:** Creating a table and inserting data are two different operations.

## 2. Understanding INSERT INTO

Now that my table exists, I can start inserting student information.

```sql
INSERT INTO students (student_id, name, age, course)
VALUES (101, 'John', 20, 'CSE');
```

This inserts one student record into the `students` table.

I can also insert multiple records in a single query:

```sql
INSERT INTO students (student_id, name, age, course)
VALUES
    (102, 'Roman', 21, 'ECE'),
    (103, 'Seth', 19, 'CSE'),
    (104, 'Randy', 22, 'IT');
```

Now my table contains multiple records.

To see the inserted data:

```sql
SELECT * FROM students;
```

`SELECT` retrieves information from a table. We'll study querying in detail in our upcoming lessons.

## 3. Understanding ALTER TABLE

Imagine that my school application initially stored only a student's ID, name, age, and course.

Later, I realise that I also need to store their email address.

Should I delete the existing table and create it again?

No! That would be unnecessary and could destroy existing data.

Instead, I can use `ALTER TABLE` to modify the structure of an existing table.

### Adding a column

```sql
ALTER TABLE students
ADD COLUMN email VARCHAR(100);
```

Now the `students` table has an additional `email` column.

### Modifying a column

Suppose I want to increase the maximum length of the course column.

```sql
ALTER TABLE students
MODIFY COLUMN course VARCHAR(100);
```

This changes the definition of the existing column.

### Renaming a column

```sql
ALTER TABLE students
RENAME COLUMN name TO student_name;
```

Now the column is called `student_name` instead of `name`.

### Dropping a column

Suppose I no longer need the age column.

```sql
ALTER TABLE students
DROP COLUMN age;
```

This removes the column and its stored values.

**Remember:** `ALTER TABLE` changes the structure of an existing table. It does not necessarily mean deleting the table and starting again.

## 4. Understanding DROP TABLE

Sometimes, I may no longer need a particular table.

For example, if I want to permanently remove the `students` table:

```sql
DROP TABLE students;
```

This removes the entire table, including:

- Its structure.
- All its records.
- Its associated table definition.

Think carefully before executing this command because it is destructive.

If another table has a Foreign Key referencing this table, MySQL may prevent the operation until the relationship is handled.

## 5. Understanding TRUNCATE TABLE

Imagine my students table contains 5,000 records.

Now suppose I want to remove all the student records but keep the table itself.

Should I use `DROP TABLE`?

No. I don't want to destroy the structure.

Instead:

```sql
TRUNCATE TABLE students;
```

This removes all records from the table while keeping its structure.

The table still exists, but it becomes empty.

An important difference is that `TRUNCATE` is a DDL operation in MySQL, whereas `DELETE` is a DML operation.

In MySQL, `TRUNCATE TABLE` also resets an `AUTO_INCREMENT` counter.

**A quick comparison:**

| Command | What does it remove? |
|---|---|
| DROP | Entire table and its data |
| TRUNCATE | All records, but keeps table structure |
| DELETE | Selected records or all records |

We'll understand the difference between these commands more deeply later in this lesson.

---

# Part 2 — Working with Table Data

## 6. Understanding UPDATE

Imagine a student changes their course from CSE to IT.

I don't need to create another student record. I simply need to modify the existing one.

This is where `UPDATE` comes in.

```sql
UPDATE students
SET course = 'IT'
WHERE student_id = 101;
```

Let's understand the query:

- `UPDATE students` tells MySQL which table I want to modify.
- `SET course = 'IT'` specifies the new value.
- `WHERE student_id = 101` identifies the record I want to update.

**Why is WHERE important?**

Without the `WHERE` condition, MySQL would update every row in the table.

For example:

```sql
UPDATE students
SET course = 'IT';
```

This would change the course of every student to IT.

So, whenever I use `UPDATE`, I need to understand which records I'm modifying.

## 7. Understanding DELETE

Now imagine a student leaves the school and I need to remove their record.

I can use:

```sql
DELETE FROM students
WHERE student_id = 101;
```

This removes the student whose ID is 101.

But what happens if I execute:

```sql
DELETE FROM students;
```

All records from the table are deleted, but the table structure remains.

This is different from `DROP TABLE`, which removes the entire table.

## 8. DELETE vs TRUNCATE vs DROP

These three commands can be confusing because all of them can result in data disappearing.

Let's understand their differences.

| Feature | DELETE | TRUNCATE | DROP |
|---|---|---|---|
| Removes records | Yes | Yes, all | Yes |
| Removes table structure | No | No | Yes |
| Supports WHERE | Yes | No | No |
| Operation category | DML | DDL | DDL |
| AUTO_INCREMENT reset | No, generally | Yes | Table is removed |
| Can remove selected records | Yes | No | No |

**Which one should I use?**

- Use `DELETE` when I want to remove specific records.
- Use `TRUNCATE` when I want to empty the entire table.
- Use `DROP` when I no longer need the table itself.

Remember that these commands have different transactional and foreign-key behaviours. In MySQL, `TRUNCATE` and most DDL operations cause implicit commits, so I should never assume I can roll them back like an ordinary transactional `DELETE`.

---

# Part 3 — Understanding Database Constraints

## 9. Why Do We Need Constraints?

So far, I've learned how to create tables and insert records.

But let's consider a real problem.

Suppose my students table looks like this:

| student_id | name | email | age |
|---|---|---|---|
| 101 | John | john@gmail.com | 20 |
| 102 | NULL | john@gmail.com | -5 |
| 101 | Roman | roman@gmail.com | 21 |

There are several problems here:

1. A student has no name.
2. Two students have the same ID.
3. Two students have the same email.
4. One student has an invalid age.

I don't want my database to accept such records.

I could write validation logic in my backend application, but what if another application directly inserts data into the database?

I need rules that are enforced by the database itself.

These rules are called **Constraints**.

A Constraint is a rule applied to a table or column that controls what kind of data can be stored.

Let's understand the important constraints one by one.

## 10. NOT NULL Constraint

Imagine every student must have a name.

A student record without a name would be incomplete.

I can enforce this rule using `NOT NULL`.

```sql
CREATE TABLE students (
    student_id INT,
    name VARCHAR(100) NOT NULL,
    age INT
);
```

Now MySQL will reject an attempt to insert NULL into the `name` column.

For example:

```sql
INSERT INTO students (student_id, name, age)
VALUES (101, NULL, 20);
```

This query will fail because the name column does not accept NULL values.

**Real-world use:** Student names, product names, and other mandatory information.

## 11. UNIQUE Constraint

Imagine every student must have a different university email address.

Two students should not be registered using the same email.

I can enforce this using `UNIQUE`.

```sql
CREATE TABLE students (
    student_id INT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
```

Now MySQL will prevent duplicate non-NULL email values.

For example, inserting two students with the same email will produce a duplicate-entry error.

An important detail: MySQL permits multiple NULL values in a UNIQUE column because NULL is not treated as an ordinary equal value.

**Real-world use:** Email addresses, usernames, registration numbers.

## 12. PRIMARY KEY Constraint

Earlier, I learned that a Primary Key uniquely identifies every record.

Now I can enforce that rule directly in MySQL.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
```

The `student_id` column is now the Primary Key.

MySQL ensures that:

- Every student ID is unique.
- A Primary Key cannot contain NULL.
- A table has only one Primary Key constraint.

A Primary Key can consist of multiple columns, which is called a Composite Primary Key.

**Real-world use:** Student IDs, employee IDs, order IDs.

## 13. FOREIGN KEY Constraint

Now let's understand how to protect relationships between tables.

Imagine I have two tables:

`students`

| student_id | name |
|---|---|
| 101 | John |
| 102 | Roman |

`attendance`

| attendance_id | student_id | status |
|---|---|---|
| 1 | 101 | Present |
| 2 | 102 | Absent |

The `attendance` table refers to students using `student_id`.

But what if someone tries to insert an attendance record for student 999, who doesn't exist?

That would create an invalid relationship.

I can prevent this using a Foreign Key.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    status VARCHAR(20),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
);
```

Now MySQL checks whether the referenced student exists before accepting the attendance record.

For example:

```sql
INSERT INTO attendance
VALUES (1, 999, 'Present');
```

If student 999 doesn't exist, MySQL rejects the insertion.

This is called **Referential Integrity**.

### ON DELETE and ON UPDATE

Foreign Keys can also define what should happen when a referenced record is deleted or updated.

Two important options are:

**ON DELETE CASCADE**

If a student is deleted, the related attendance records are automatically deleted.

```sql
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON DELETE CASCADE
```

**ON UPDATE CASCADE**

If the referenced student ID changes, the corresponding Foreign Key values are updated automatically.

```sql
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON UPDATE CASCADE
```

These options should be selected carefully because cascading operations can affect many records.

## 14. DEFAULT Constraint

Imagine that whenever I register a new student, their account status should initially be `Active`.

Instead of manually entering `Active` every time, I can define a default value.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);
```

Now if I insert a student without specifying the status:

```sql
INSERT INTO students (student_id, name)
VALUES (101, 'John');
```

MySQL automatically assigns `Active` to the status column.

A default value is used when a column is omitted from an INSERT statement or the `DEFAULT` keyword is specified.

It does not replace an explicitly supplied NULL.

**Real-world use:** Account status, registration date, default quantity.

## 15. CHECK Constraint

Imagine my school only accepts students whose age is 16 or above.

I want MySQL to reject records where the age is below 16.

I can use the `CHECK` constraint.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 16)
);
```

Now MySQL checks the condition whenever a record is inserted or updated.

For example:

```sql
INSERT INTO students
VALUES (101, 'John', 14);
```

This query will fail because the age condition is not satisfied.

**Real-world use:**

- Age must be greater than or equal to 16.
- Salary must be greater than zero.
- Marks must be between 0 and 100.

MySQL enforces CHECK constraints in modern versions (MySQL 8.0.16 and later).

---

# Part 4 — Combining Constraints

## 16. Using Multiple Constraints Together

In real applications, a column or table usually needs more than one rule.

Let's create a proper students table.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    course VARCHAR(50) DEFAULT 'Undeclared'
);
```

Let's understand the rules:

| Column | Constraint | Purpose |
|---|---|---|
| student_id | PRIMARY KEY | Uniquely identifies students |
| student_id | AUTO_INCREMENT | Generates IDs automatically |
| name | NOT NULL | Name is mandatory |
| email | UNIQUE | Prevents duplicate emails |
| age | CHECK | Ensures age is at least 16 |
| course | DEFAULT | Assigns a default course |

Notice that `AUTO_INCREMENT` is not itself a constraint in the same sense as the others. It is a MySQL column attribute that automatically generates sequential numeric values.

Now my database itself protects the data instead of relying entirely on my backend application.

## 17. Column-Level vs Table-Level Constraints

There are two common ways to define constraints.

### Column-Level

A constraint is written directly alongside the column definition.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

### Table-Level

A constraint is declared separately after the column definitions.

```sql
CREATE TABLE students (
    student_id INT,
    name VARCHAR(100),

    PRIMARY KEY (student_id)
);
```

For a Composite Primary Key, I need a table-level declaration:

```sql
CREATE TABLE enrollments (
    student_id INT,
    subject_id INT,

    PRIMARY KEY (student_id, subject_id)
);
```

Both approaches are useful. I'll choose the one that makes my table definition easier to understand.

---

# Part 5 — Putting Everything Together

## 18. Building a Mini School Management Database

Now I want to combine everything I've learned.

Instead of studying each command independently, I'll create a small database structure that resembles a real application.

### Step 1 — Create the Students Table

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    course VARCHAR(50) DEFAULT 'Undeclared'
);
```

### Step 2 — Create the Subjects Table

```sql
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL UNIQUE
);
```

### Step 3 — Create the Enrollments Table

A student can enrol in multiple subjects, and a subject can have multiple students.

This is a Many-to-Many relationship.

I'll use an `enrollments` table to connect them.

```sql
CREATE TABLE enrollments (
    student_id INT,
    subject_id INT,

    PRIMARY KEY (student_id, subject_id),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (subject_id)
    REFERENCES subjects(subject_id)
);
```

### Step 4 — Insert Students

```sql
INSERT INTO students (name, email, age, course)
VALUES
    ('John', 'john@gmail.com', 20, 'CSE'),
    ('Roman', 'roman@gmail.com', 21, 'ECE'),
    ('Seth', 'seth@gmail.com', 19, 'CSE');
```

### Step 5 — Insert Subjects

```sql
INSERT INTO subjects (subject_name)
VALUES
    ('Database Management Systems'),
    ('Data Structures'),
    ('Operating Systems');
```

### Step 6 — Create Enrollments

```sql
INSERT INTO enrollments (student_id, subject_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 3);
```

Now students and subjects are connected through the `enrollments` table.

I'll learn how to retrieve information from these related tables using JOIN operations in an upcoming lesson.

---

# Part 6 — Practical Understanding

## 19. Important Things I Should Experiment With

I don't want to just copy SQL queries and assume I've understood them.

I should deliberately try things that should work and things that should fail.

For example:

**Experiment 1: Duplicate Primary Key**

Try inserting two students with the same `student_id`.

What happens?

**Experiment 2: NULL in a NOT NULL Column**

Try inserting a student without a name.

What error does MySQL return?

**Experiment 3: Duplicate Email**

Try registering two students using the same email.

Why does the second insertion fail?

**Experiment 4: Invalid Foreign Key**

Try inserting an enrollment for a student who doesn't exist.

What is MySQL protecting me from?

**Experiment 5: CHECK Constraint**

Try inserting a student whose age is 12.

Does MySQL accept the record?

**Experiment 6: ALTER TABLE**

Add a new column named `phone` to the students table.

Then modify its data type.

**Experiment 7: DELETE vs TRUNCATE vs DROP**

Experiment with these commands on temporary tables and observe what happens to the records and structure.

Be careful with destructive commands. Never experiment with DROP or TRUNCATE on tables containing data you need.

---

# 20. Quick Revision

| Command / Concept | Purpose |
|---|---|
| CREATE TABLE | Creates a new table |
| INSERT INTO | Inserts new records |
| ALTER TABLE | Modifies table structure |
| UPDATE | Modifies existing records |
| DELETE | Removes selected or all records |
| TRUNCATE | Removes all records |
| DROP TABLE | Removes the entire table |
| NOT NULL | Prevents NULL values |
| UNIQUE | Prevents duplicate non-NULL values |
| PRIMARY KEY | Uniquely identifies records |
| FOREIGN KEY | Maintains relationships between tables |
| DEFAULT | Provides a default value |
| CHECK | Enforces a condition on values |
| AUTO_INCREMENT | Automatically generates numeric values |

## 21. What Should I Be Able to Explain After This Lesson?

Before moving forward, I should be able to explain these concepts in my own words:

1. How do I create a table in MySQL?
2. What is the difference between CREATE TABLE and ALTER TABLE?
3. How can I add, modify, rename, and remove columns?
4. What is the difference between INSERT, UPDATE, and DELETE?
5. What is the difference between DELETE, TRUNCATE, and DROP?
6. Why do we need database constraints?
7. What is the difference between PRIMARY KEY and UNIQUE?
8. How does a FOREIGN KEY maintain referential integrity?
9. What is the purpose of ON DELETE CASCADE?
10. How do DEFAULT and CHECK constraints work?
11. What is the difference between column-level and table-level constraints?
12. How can multiple constraints work together in a single table?

If I can explain these concepts and demonstrate them using MySQL queries, I've understood this lesson.

---

## What's Next?

Now that I know how to create tables, manage their structure, manipulate records, and enforce rules on data, I'm ready to understand how SQL queries actually retrieve information.

**Lesson 09 — Introduction to SQL Queries and SELECT**

I'll start learning how to retrieve data from tables, select specific columns, filter records, and gradually build more meaningful queries.

The goal is to move from simply storing data to actually working with and extracting useful information from it.