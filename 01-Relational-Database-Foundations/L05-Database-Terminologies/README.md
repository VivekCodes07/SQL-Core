# Lesson 05 — Database Terminologies

## Why Am I Learning This?

I already understand what a relational database is, how tables store data, and how I can use SQL commands to interact with MySQL.

But as I continue learning SQL, I will keep encountering terms such as:

- Schema
- Primary Key
- Foreign Key
- Index
- Constraint
- Query
- Relationship
- Database Engine

I might understand individual SQL commands, but if I don't understand these terms, it will become difficult to understand how a real database is designed.

For example, when I hear that a table has a primary key, I should understand why that key exists and what problem it solves. When I hear that a column has an index, I should understand how it can help MySQL find data more efficiently.

My goal is not to memorize definitions. I want to build a mental model of how relational databases are organized and how their different parts work together.

## What Am I Going to Learn?

By the end of this lesson, I want to understand:

1. Database, schema, table, row and column.
2. Records, fields and data types.
3. Primary keys and foreign keys.
4. Constraints and data integrity.
5. Indexes and why they matter.
6. Queries and database engines.
7. Relationships between tables.
8. How all these concepts fit together in a real application.

---

## 1. The Structure of a Database

Before learning the more technical terms, I want to understand how the basic pieces fit together.

Imagine that I am building a school-management application.

The application needs to store students, teachers, courses and enrollments. These are different kinds of information, so I need a way to organize them.

A relational database organizes this information using tables.

### Understanding the hierarchy

```text
MySQL Server
│
└── Database: school_management
    │
    ├── Table: students
    │   ├── Columns: id, name, age
    │   └── Rows: individual student records
    │
    ├── Table: courses
    │   ├── Columns: id, course_name
    │   └── Rows: individual course records
    │
    └── Table: enrollments
        ├── Columns: student_id, course_id
        └── Rows: student-course relationships
```

This diagram shows the general organization of the information.

The database groups related tables together. Each table represents a particular kind of information, and each row stores one record.

Let's understand the terminology one concept at a time.

## 2. Database

A **database** is an organized collection of data that I can store, manage and retrieve.

For my school-management application, I might create a database named:

```sql
CREATE DATABASE school_management;
```

The database can contain tables for students, teachers, courses, attendance and other information.

I can think of the database as the overall container that organizes the data for a particular application.

However, the database itself is not the same thing as a table. The database contains the tables.

## 3. Schema

The word *schema* is used in different ways depending on the database system.

In the context of relational databases, a schema generally describes the structure or organization of database objects, such as tables, columns, data types, constraints and relationships.

For example, imagine the following table definition:

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT
);
```

This definition describes the structure of the `students` table.

It tells MySQL that the table has three columns and specifies the data type of each column.

The table's structure is part of its schema.

### Database vs schema in MySQL

This is an important detail: in MySQL, `CREATE SCHEMA` is a synonym for `CREATE DATABASE`.

So, in MySQL, I can use:

```sql
CREATE DATABASE school_management;
```

or:

```sql
CREATE SCHEMA school_management;
```

Both create a database.

In some other database systems, such as PostgreSQL, a database and a schema are distinct levels of organization.

**What I should remember:** the word *schema* can refer to a table's structure or to a named collection of database objects, depending on the context and database system.

## 4. Table

A **table** stores a particular category of information in a relational database.

For example, a `students` table stores student information, while a `courses` table stores course information.

Here is an example of a `students` table:

```text
+----+--------------+-----+
| id | name         | age |
+----+--------------+-----+
|  1 | John Cena    |  21 |
|  2 | Roman Reigns |  20 |
|  3 | Cody Rhodes  |  22 |
+----+--------------+-----+
```

The names are sample data; the ages are fictional.

This table has three columns and three records.

The table defines how a particular category of data is organized. It does not mean that every table in the database must have the same columns.

For example, a `courses` table could have columns such as `id`, `course_name` and `credits`.

## 5. Row, Record and Tuple

A **row** represents one entry in a table.

In database discussions, the words *row* and *record* are commonly used interchangeably. In relational theory, a row is also called a *tuple*.

Look at this example:

```text
+----+--------------+-----+
| id | name         | age |
+----+--------------+-----+
|  1 | John Cena    |  21 |
+----+--------------+-----+
```

The row represents one student's information.

The entire row contains the values `1`, `John Cena` and `21`.

A table can contain thousands or millions of rows. Each row represents one record in that table.

## 6. Column, Field and Attribute

A **column** defines a particular piece of information that each row can store.

In the `students` table, the columns are:

- `id`
- `name`
- `age`

Each column has a name and a data type.

For example:

```text
students
│
├── id    → INT
├── name  → VARCHAR(100)
└── age   → INT
```

A column describes the kind of information stored in that position.

The terms *attribute* and *field* are also used in database discussions, but their exact meanings depend on context. In relational theory, an attribute corresponds to a column. In everyday SQL usage, it is clearest to call the table's vertical structure a **column**.

## 7. Data Type

A **data type** determines what kind of value a column can store and how MySQL handles that value.

For example:

```sql
CREATE TABLE courses (
    id INT,
    course_name VARCHAR(100),
    fee DECIMAL(10, 2),
    start_date DATE
);
```

Here:

| Column | Data type | Purpose |
|---|---|---|
| `id` | `INT` | Stores integer values |
| `course_name` | `VARCHAR(100)` | Stores variable-length text |
| `fee` | `DECIMAL(10, 2)` | Stores decimal numbers with two fractional digits |
| `start_date` | `DATE` | Stores calendar dates |

Choosing an appropriate data type helps me define what information belongs in each column.

For example, a course fee should generally use an appropriate numeric type rather than a text type, especially when I need to perform calculations.

I will study MySQL data types in detail in Lesson 06.

## 8. Primary Key

A **primary key** uniquely identifies each row in a table.

Imagine that two students have the same name. If I try to identify a student using only their name, I might not know which record I mean.

That is why I need a unique identifier.

For example:

```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
```

Now `id` is the primary key.

The primary key must contain unique, non-`NULL` values. A table has only one primary key constraint, although that key can consist of multiple columns.

### Why is a primary key useful?

Suppose the table contains:

```text
+----+--------------+-----+
| id | name         | age |
+----+--------------+-----+
|  1 | John Cena    |  21 |
|  2 | Roman Reigns |  20 |
|  3 | Cody Rhodes  |  22 |
+----+--------------+-----+
```

If I want to identify the student whose ID is `2`, I can write:

```sql
SELECT *
FROM students
WHERE id = 2;
```

The primary key gives each row a reliable identity.

Without a suitable key, identifying, updating and relating records can become much harder.

## 9. Foreign Key

A **foreign key** connects records in one table to records in another table by referencing a key in the referenced table.

Suppose my application stores students and courses separately.

A student can enrol in a course, and a course can have many students. I need a way to record which student is enrolled in which course.

I can create an `enrollments` table.

```text
students
+----+--------------+
| id | name         |
+----+--------------+
|  1 | John Cena    |
|  2 | Roman Reigns |
+----+--------------+

courses
+----+----------------+
| id | course_name    |
+----+----------------+
| 10 | Java           |
| 20 | Database Design|
+----+----------------+

enrollments
+------------+-----------+
| student_id | course_id |
+------------+-----------+
| 1          | 10        |
| 1          | 20        |
| 2          | 10        |
+------------+-----------+
```

The `student_id` column refers to `students.id`, and `course_id` refers to `courses.id`.

I can define these relationships using foreign keys:

```sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,

    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

This example assumes the referenced tables already exist and their referenced columns are valid keys.

### What problem does a foreign key solve?

A foreign key helps enforce referential integrity.

For example, MySQL can prevent an enrollment from referencing a student ID that does not exist in the referenced table, subject to the constraint and its configuration.

**What I should remember:**

- A primary key identifies a row in its own table.
- A foreign key establishes a reference to a key in another table or, where appropriate, the same table.

I will study primary keys and foreign keys in detail in Lessons 19 and 20.

## 10. Relationship

A **relationship** describes how records in different tables are associated with one another.

For example, in my school-management database:

- A student can enrol in multiple courses.
- A course can have multiple students.
- A teacher can teach multiple courses.

Common relationship patterns include:

### One-to-one

One record is associated with at most one record in another table, and vice versa.

Example: a person and a separate record containing that person's unique profile details.

### One-to-many

One record can be associated with many records in another table.

Example: one teacher can be associated with several courses.

### Many-to-many

Many records in one table can be associated with many records in another table.

Example: many students can enrol in many courses.

A many-to-many relationship is commonly represented using a junction table such as `enrollments`.

```text
students ─────< enrollments >───── courses
                  │
                  ├── student_id
                  └── course_id
```

The foreign keys connect the enrollment records to their respective students and courses.

Understanding relationships is essential because real applications rarely store all their information in one giant table.

## 11. Constraint

A **constraint** is a rule that the database enforces on stored data.

Constraints help prevent invalid or inconsistent information from being stored.

For example, a student should not have the same primary key as another student. An enrollment should not reference a nonexistent student when a suitable foreign key is enforced.

Common MySQL constraints include:

| Constraint | Purpose |
|---|---|
| `PRIMARY KEY` | Uniquely identifies each row and disallows `NULL` key values |
| `FOREIGN KEY` | Enforces a valid reference to a key in another table or the same table |
| `UNIQUE` | Prevents duplicate values for the constrained column or column combination |
| `NOT NULL` | Prevents a column from storing `NULL` |
| `CHECK` | Enforces a specified condition on values |

For example:

```sql
CREATE TABLE courses (
    id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    fee DECIMAL(10, 2) CHECK (fee >= 0)
);
```

This definition requires each course to have a unique ID, requires a course name, and declares a condition that the fee must be nonnegative.

The exact enforcement behavior of some constraints depends on the MySQL version and configuration. In modern MySQL versions, `CHECK` constraints are enforced.

Constraints are important because I should not have to rely entirely on my application code to prevent invalid data.

## 12. Index

An **index** is a database structure that can help MySQL find rows more efficiently.

Imagine that a table contains one million student records.

If I frequently search for a student using a particular column, MySQL may need to examine many rows when no suitable index exists.

An index can provide a more efficient way to locate matching records.

For example:

```sql
CREATE INDEX idx_students_name
ON students(name);
```

This creates an index on the `name` column.

A query such as:

```sql
SELECT *
FROM students
WHERE name = 'John Cena';
```

may benefit from this index.

However, an index does not guarantee that every query will become faster. MySQL's optimizer chooses an execution plan based on the query, available indexes, statistics and other factors.

### Why not index every column?

Indexes also have costs.

- They consume storage.
- Inserts, updates and deletes may require index maintenance.
- Too many indexes can increase the cost of modifying data.

So, an index is a tool for improving performance when it suits the queries I actually run.

### Primary key and index

In MySQL's InnoDB storage engine, a primary key is implemented as the clustered index. Secondary indexes also have their own structures.

For now, I should remember that a primary key defines a uniqueness rule and identifies records, while an index is a structure used to support efficient data access. These concepts are related, but they are not interchangeable.

I will explore indexes and query performance in Lesson 28.

## 13. Query

A **query** is a request I make to a database.

For example:

```sql
SELECT name
FROM students
WHERE age >= 21;
```

This query asks MySQL to retrieve the names of students whose age is at least 21.

Queries can retrieve data, and SQL statements can also request changes to database structures or stored records.

In everyday conversation, people often use *query* broadly to refer to an SQL statement, although the terms are not always used identically in every technical context.

For now, I should understand a query as an instruction or request that I send to the database.

## 14. Database Engine

A **database engine** is the component responsible for implementing core database operations, including how data is stored, retrieved and managed.

In MySQL, storage engines determine important details about how tables store and access data.

Two names I will encounter are:

- **InnoDB:** MySQL's default storage engine in modern versions. It supports transactions, foreign keys and crash recovery.
- **MyISAM:** Another MySQL storage engine, historically used for certain workloads, but without InnoDB-style transaction support.

For my learning and most backend projects, I will primarily work with InnoDB.

I can explicitly select it when creating a table:

```sql
CREATE TABLE example (
    id INT PRIMARY KEY
) ENGINE = InnoDB;
```

The engine matters because features such as transactions and foreign-key enforcement depend on the storage engine and database configuration.

## 15. Putting the Concepts Together

Now I want to see how the terminology connects in a single example.

Imagine I am designing the data model for my school-management application.

```sql
CREATE DATABASE school_management;

USE school_management;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT
) ENGINE = InnoDB;

CREATE TABLE courses (
    id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
) ENGINE = InnoDB;
```

I have used several concepts in this design:

- `school_management` is the database.
- `students`, `courses` and `enrollments` are tables.
- `id`, `name`, `age`, `student_id` and `course_id` are columns.
- `INT` and `VARCHAR(100)` are data types.
- The primary keys identify records.
- The foreign keys connect enrollments to students and courses.
- `NOT NULL` is a constraint.
- `InnoDB` is the storage engine.
- The tables collectively represent part of the database's structure.

The composite primary key on `enrollments` also prevents the same student-course pair from appearing more than once.

This is how the terminology stops being a collection of definitions and starts becoming a useful way to reason about database design.

---

## 16. What I Have Learned

I should now be able to explain these concepts in my own words:

- **Database:** An organized collection of data.
- **Schema:** A description or organization of database structures, with exact usage depending on the database system.
- **Table:** A structure that organizes data into rows and columns.
- **Row / record:** One entry in a table.
- **Column / attribute:** A defined piece of information in a table.
- **Data type:** Defines the kind of value a column can store.
- **Primary key:** Uniquely identifies each row.
- **Foreign key:** References a key to establish and enforce a relationship.
- **Relationship:** Describes how records in tables are associated.
- **Constraint:** A rule enforced on data.
- **Index:** A structure that can improve data access efficiency.
- **Query:** A request or instruction sent to the database.
- **Database engine:** Implements how data is stored, retrieved and managed.

## What Comes Next?

In Lesson 06, I will study MySQL data types in more detail.

I will learn how to choose appropriate types for integers, text, decimal values, dates and other kinds of information.

The goal is to stop choosing data types randomly and start understanding why a particular type makes sense for a particular column.