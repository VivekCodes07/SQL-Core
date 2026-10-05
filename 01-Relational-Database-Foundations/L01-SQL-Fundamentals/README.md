# Lesson 01 — Understanding SQL & Relational Databases

## Why Am I Learning This?

I already know MongoDB.

I know that an application needs somewhere to store data, and I already understand concepts like:

* Database
* Collection
* Document
* Field
* CRUD
* Queries

So when I start SQL, I don't want to start by memorizing things like:

```sql
SELECT
INSERT
UPDATE
DELETE
```

That would only teach me syntax.

I want to understand **what problem SQL and relational databases are solving in the first place**.

If I understand the problem and the mental model, the syntax will become much easier later.

My goal for this lesson is simple:

> **I want to understand how a relational database thinks about data.**

---

# 1. Before SQL: Why Do I Even Need a Database?

Imagine I am building a college application.

I need to store information about students.

At first, I might think:

```text
Vivek, 20, CSE
Rahul, 21, CSE
Aman, 19, ECE
```

This looks simple.

But a real application doesn't just need to store students.

Soon I need:

```text
Students
Courses
Teachers
Departments
Attendance
Exams
Marks
Fees
Orders
Payments
```

And these things are not independent.

For example:

```text
A student belongs to a department.

A student takes courses.

A course is taught by a teacher.

A department has many students.

A student receives marks.

An exam belongs to a course.
```

Now the problem becomes much bigger.

I don't just need to **store data**.

I need to:

* Find data
* Add data
* Change data
* Delete data
* Connect related data
* Prevent invalid data
* Keep data consistent
* Ask complicated questions about the data

This is the problem a database system helps me solve.

---

# 2. What Is a Database?

A database is a system for **storing and managing data in an organized way**.

The important word here is:

> **managing**

A database isn't just a giant storage box.

It helps my application work with data.

For example, I might ask:

```text
Give me all students from CSE.
```

Or:

```text
Which student has the highest marks?
```

Or:

```text
Which students are enrolled in SQL?
```

Or:

```text
How many students are in each department?
```

A database system is designed to handle these kinds of operations efficiently and reliably.

---

# 3. There Are Different Ways to Model Data

This is where MongoDB and SQL start becoming interesting.

I already know MongoDB.

MongoDB is a **document database**.

It naturally thinks in terms of:

```text
Database
   ↓
Collection
   ↓
Document
   ↓
Fields
```

For example:

```javascript
{
    name: "Vivek",
    age: 20,
    department: "CSE"
}
```

A relational database thinks about data differently.

It primarily thinks in terms of:

```text
Database
   ↓
Tables
   ↓
Rows
   ↓
Columns
```

For example:

```text
students

+----+--------+-----+------------+
| id | name   | age | department |
+----+--------+-----+------------+
| 1  | Vivek  | 20  | CSE        |
| 2  | Rahul  | 21  | CSE        |
| 3  | Aman   | 19  | ECE        |
+----+--------+-----+------------+
```

This is the first major mental shift I need to make.

---

# 4. What Does "Relational" Mean?

This is the most important question of this lesson.

Why do we call these databases **relational**?

Because data can be represented as **relations between structured sets of data**, and those relationships can be represented between tables.

Let's take:

```text
students
```

and:

```text
departments
```

I could have:

```text
students

+----+--------+---------------+
| id | name   | department_id |
+----+--------+---------------+
| 1  | Vivek  | 10            |
| 2  | Rahul  | 10            |
| 3  | Aman   | 20            |
+----+--------+---------------+
```

and:

```text
departments

+----+------+
| id | name |
+----+------+
| 10 | CSE  |
| 20 | ECE  |
+----+------+
```

Now I have a relationship:

```text
Vivek
  ↓
department_id = 10
  ↓
departments.id = 10
  ↓
CSE
```

The data isn't just sitting in isolated tables.

The tables can be **related**.

That is a fundamental idea behind relational databases.

---

# 5. Why Not Just Put Everything Into One Table?

This is where relational database design starts becoming interesting.

Suppose I create one huge table:

```text
students

student_id
student_name
student_age
department_name
department_head
course_name
teacher_name
teacher_email
...
```

At first this seems convenient.

But imagine:

```text
CSE has 1,000 students.
```

Then I may end up storing:

```text
CSE
Computer Science Department
Dr. Sharma
...
```

over and over again.

That creates **duplicate data**.

Now suppose the department head changes.

I may have to update hundreds or thousands of records.

That is dangerous.

I could accidentally update some rows but miss others.

Now my database contains contradictory information.

Relational database design gives me a better idea:

> Separate different concepts into different tables and connect them when necessary.

So instead:

```text
students
departments
courses
teachers
```

I can keep each concept in its own place.

Then relationships connect them.

---

# 6. Tables Represent Concepts

A table usually represents some meaningful thing or concept in my application.

For example:

```text
students
```

represents students.

```text
courses
```

represents courses.

```text
teachers
```

represents teachers.

```text
departments
```

represents departments.

```text
orders
```

represents orders.

```text
products
```

represents products.

This gives me an important way to think:

> **A table isn't just a grid. It represents a concept in my application.**

---

# 7. Then What Is a Row?

Once I have a table representing a concept, each row represents **one instance of that concept**.

For example:

```text
students

+----+--------+-----+
| id | name   | age |
+----+--------+-----+
| 1  | Vivek  | 20  |
| 2  | Rahul  | 21  |
| 3  | Aman   | 19  |
+----+--------+-----+
```

The table represents:

```text
Students
```

The first row represents:

```text
One student → Vivek
```

The second row:

```text
One student → Rahul
```

The third row:

```text
One student → Aman
```

So I can think:

```text
Table
  ↓
Collection of similar records

Row
  ↓
One record
```

---

# 8. Then What Is a Column?

A column describes **one property of the records**.

In:

```text
students

+----+--------+-----+
| id | name   | age |
+----+--------+-----+
```

I have:

```text
id
name
age
```

These describe different properties of a student.

So:

```text
id
↓
Student identifier

name
↓
Student name

age
↓
Student age
```

A useful mental model is:

```text
Table
    ↓
What kind of thing?

Row
    ↓
Which specific thing?

Column
    ↓
What property of that thing?
```

---

# 9. The Relational Mental Model

At this point I should be able to visualize a relational database like this:

```text
                 DATABASE
                     |
        +------------+------------+
        |            |            |
        ↓            ↓            ↓
     students      courses     teachers
        |            |            |
       rows         rows         rows
        |            |            |
     columns      columns      columns
```

And when these concepts need to interact:

```text
students
    |
    ↓
relationships
    |
    ↓
courses
```

This is the mental model I want to build before learning SQL syntax.

---

# 10. But How Are Tables Connected?

Now we reach two extremely important concepts:

```text
Primary Key
Foreign Key
```

Don't worry about memorizing their formal definitions yet.

Understand the problem first.

Suppose I have:

```text
departments

+----+------+
| id | name |
+----+------+
| 10 | CSE  |
| 20 | ECE  |
+----+------+
```

The `id` uniquely identifies each department.

So:

```text
10 → CSE
20 → ECE
```

That unique identifier can be used to identify a particular row.

This is the basic idea behind a **primary key**.

---

# 11. Primary Key — The Identity of a Row

Suppose:

```text
students

+----+--------+-----+
| id | name   | age |
+----+--------+-----+
| 1  | Vivek  | 20  |
| 2  | Rahul  | 21  |
| 3  | Aman   | 19  |
+----+--------+-----+
```

Here:

```text
id
```

can uniquely identify each student.

So:

```text
1 → Vivek
2 → Rahul
3 → Aman
```

I can think of a primary key as:

> **The identity of a row.**

This becomes extremely important later when we work with relationships.

---

# 12. Foreign Key — Connecting Tables

Now look at:

```text
departments

+----+------+
| id | name |
+----+------+
| 10 | CSE  |
| 20 | ECE  |
+----+------+
```

and:

```text
students

+----+--------+---------------+
| id | name   | department_id |
+----+--------+---------------+
| 1  | Vivek  | 10            |
| 2  | Rahul  | 10            |
| 3  | Aman   | 20            |
+----+--------+---------------+
```

The `department_id` in `students` points toward a department.

So:

```text
Vivek
   ↓
department_id = 10
   ↓
departments.id = 10
   ↓
CSE
```

That `department_id` can be a **foreign key**.

So I can think:

```text
Primary Key
↓
Identifies a row

Foreign Key
↓
Points to related data
```

We'll study this properly later.

For now, I only need the mental model.

---

# 13. Relationships Are the Real Power

Once tables can be related, I can represent real-world structures.

### One Department → Many Students

```text
CSE
 |
 +---- Vivek
 |
 +---- Rahul
 |
 +---- Priya
```

### One Customer → Many Orders

```text
Customer
   |
   +---- Order 1
   +---- Order 2
   +---- Order 3
```

### Students ↔ Courses

A student can take many courses.

A course can have many students.

```text
Students
   ↕
Enrollments
   ↕
Courses
```

These relationships are one of the biggest things I need to understand when moving from MongoDB to SQL.

---

# 14. Now Where Does SQL Come In?

So far I've talked about:

```text
Database
Tables
Rows
Columns
Keys
Relationships
```

But how do I actually **talk to** the database?

That's where SQL comes in.

SQL stands for:

> **Structured Query Language**

SQL is the language I use to communicate with a relational database.

For example:

```sql
SELECT name
FROM students;
```

I'm asking the database:

> "Give me the `name` of the students."

SQL is therefore **not the database**.

It is the language I use to interact with the database.

---

# 15. SQL vs MySQL

This distinction is important.

I may hear people casually say:

> "I'm learning MySQL."

But technically:

```text
SQL
↓
Language
```

while:

```text
MySQL
↓
Relational Database Management System
```

MySQL is software that stores and manages my relational data and understands SQL.

Other relational database systems include:

```text
PostgreSQL
MySQL
SQLite
Microsoft SQL Server
Oracle Database
MariaDB
```

They all work with SQL, although each can have its own extensions and differences.

So:

```text
SQL ≠ MySQL
```

A simple way to remember:

> **SQL is the language. MySQL is one system that speaks that language.**

---

# 16. What Is an RDBMS?

RDBMS means:

> **Relational Database Management System**

Let's break that down.

### Relational

Data can be represented using related tables.

### Database

The system stores data.

### Management System

The software manages that data and provides ways to work with it.

So:

```text
MySQL
PostgreSQL
SQLite
SQL Server
```

are examples of relational database management systems.

---

# 17. SQL Is Not Just One Command

I might initially think SQL means:

```sql
SELECT
```

But SQL is much larger than that.

I will eventually use SQL to:

### Define structure

```sql
CREATE
ALTER
DROP
```

### Add or modify data

```sql
INSERT
UPDATE
DELETE
```

### Read data

```sql
SELECT
```

### Work with transactions

```sql
COMMIT
ROLLBACK
```

### Control access

```sql
GRANT
REVOKE
```

I don't need to memorize these now.

I'm only building awareness of what SQL can do.

---

# 18. SQL Is Declarative

This is an important concept for understanding how SQL feels different from normal programming.

Suppose I write:

```sql
SELECT name
FROM students
WHERE age >= 20;
```

I'm essentially saying:

> "I want the names of students whose age is at least 20."

I'm describing **what I want**.

I'm not manually writing:

```text
Go to row 1
Check age
If age >= 20, save name
Go to row 2
Check age
...
```

The database figures out how to execute my request.

That's why SQL is largely considered a **declarative language**.

I describe the result I want.

The database handles the execution strategy.

---

# 19. What Actually Happens When I Run SQL?

Suppose I eventually run:

```sql
SELECT name
FROM students
WHERE age >= 20;
```

I can imagine the process like this:

```text
                My SQL Query
                     ↓
              Database receives it
                     ↓
               SQL is parsed
                     ↓
         Database understands the request
                     ↓
          Query planner chooses a strategy
                     ↓
             Database accesses data
                     ↓
                Result is produced
                     ↓
                I receive rows
```

I don't need to understand query planning yet.

That comes much later when I learn about indexes and performance.

For now, the important idea is:

> **SQL is my request. The database is responsible for executing that request.**

---

# 20. SQL vs MongoDB

Since I already know MongoDB, I can use it as a bridge.

### MongoDB

```text
Database
    ↓
Collection
    ↓
Document
    ↓
Fields
```

Example:

```javascript
{
    _id: 1,
    name: "Vivek",
    age: 20
}
```

### Relational Database

```text
Database
    ↓
Table
    ↓
Row
    ↓
Columns
```

Example:

```text
students

+----+--------+-----+
| id | name   | age |
+----+--------+-----+
| 1  | Vivek  | 20  |
+----+--------+-----+
```

A rough conceptual mapping is:

| MongoDB    | Relational Database      |
| ---------- | ------------------------ |
| Database   | Database                 |
| Collection | Table                    |
| Document   | Row                      |
| Field      | Column                   |
| `_id`      | Primary Key              |
| Reference  | Foreign Key relationship |

But I need to be careful.

This does **not** mean:

> "SQL is MongoDB with different syntax."

The underlying data-modeling approaches are different.

MongoDB naturally encourages document-oriented modeling.

Relational databases naturally encourage structured tables and relationships.

---

# 21. The Most Important Difference I Need to Understand

If I remember only one difference from this lesson, it should be this:

### MongoDB asks me to think primarily in documents.

```text
Student
   ↓
Document
   ↓
Related information can live inside it
```

### Relational databases ask me to think primarily in structured data and relationships.

```text
Student
   ↓
students table

Department
   ↓
departments table

Relationship
   ↓
Foreign key
```

Neither approach is automatically "better."

The right choice depends on the application and the data.

As a backend developer, I want to understand both.

---

# 22. A Real-World Example

Let's say I am building an e-commerce application.

I need:

```text
Users
Products
Orders
Payments
```

A relational database might model this as:

```text
users
   |
   ↓
orders
   |
   ↓
order_items
   |
   ↓
products

orders
   |
   ↓
payments
```

Now I can ask questions such as:

```text
Which orders belong to Vivek?

What products did Vivek buy?

How much did Vivek spend?

Which product has sold the most?

Which customers have never placed an order?

What is the total revenue?
```

This is where SQL becomes incredibly powerful.

SQL isn't just about storing rows.

It's about being able to **ask meaningful questions about connected data**.

---

# 23. The Mental Model I Want to Build

At the end of this lesson, I want this picture in my head:

```text
                    APPLICATION
                         |
                         | SQL
                         ↓
                RELATIONAL DATABASE
                         |
             +-----------+-----------+
             |           |           |
             ↓           ↓           ↓
          USERS       ORDERS      PRODUCTS
             |           |           |
             |           |           |
             +------ RELATIONSHIPS--+
                         |
                  Primary / Foreign
                       Keys
```

The application communicates with the database using SQL.

The database stores structured data in tables.

Tables contain rows and columns.

Keys allow tables to be related.

SQL lets me ask questions about and manipulate that data.

---

# 24. What I Should Know Before Moving On

Before I move to the next lesson, I should be able to explain these **without looking at the README**:

### What is a database?

A system for storing and managing data.

### What is a relational database?

A database that organizes structured data into relations/tables and allows those data sets to be connected through relationships.

### What is SQL?

A language used to communicate with relational databases.

### What is MySQL?

A relational database management system that uses SQL.

### What is a table?

A structure representing a particular type of data or concept.

### What is a row?

One record in a table.

### What is a column?

A property/attribute of the records in a table.

### What is a primary key?

A value or set of values that uniquely identifies a row.

### What is a foreign key?

A value that establishes a relationship with a key in another table.

### Why do we use multiple tables?

To organize different concepts separately, reduce unnecessary duplication, and represent relationships between data.

---

# 25. What I Am NOT Learning Yet

I am deliberately not going deep into:

```text
CREATE TABLE
INSERT
SELECT
WHERE
JOIN
GROUP BY
Indexes
Transactions
Normalization
```

yet.

I will learn these properly in the upcoming lessons.

Right now, I am building the foundation that will make those topics understandable.

---

# 26. My Learning Check

I should stop here and ask myself:

### Question 1

If someone asks me:

> "What is SQL?"

Can I explain it without saying:

> "It's a database."

Because SQL is **not** the database.

---

### Question 2

If someone asks:

> "What is MySQL?"

Can I explain the difference between MySQL and SQL?

---

### Question 3

If I see:

```text
students
```

can I understand why it might be a table?

---

### Question 4

If I see:

```text
students.department_id
```

and:

```text
departments.id
```

can I understand why those two values might be connected?

---

### Question 5

Can I explain why putting every piece of application data into one enormous table can become problematic?

---

### Question 6

Can I explain the difference between:

```text
Table
Row
Column
```

without memorizing textbook definitions?

If yes, I am ready for the next lesson.

---

# 27. Lesson Progression

My SQL learning journey will build like this:

```text
L01
Understand the relational database mental model
        ↓
L02
Actually create tables and understand their structure
        ↓
L03
Learn how to read data with SELECT
        ↓
L04
Filter and sort data
        ↓
L05
Work with functions and NULL
        ↓
L06
Aggregate data
        ↓
L07
Insert, update and delete data
        ↓
L08
Protect data using constraints
        ↓
L09
Design relationships between tables
        ↓
L10
Combine tables using JOINs
        ↓
L11
Write complex queries using subqueries and CTEs
        ↓
...
```

Every lesson will build on the previous mental model.

---

# What I Learned

In this lesson, I learned that SQL is not something I should approach as a list of commands.

I first need to understand how relational databases think about data.

The core idea is:

```text
Database
    ↓
Tables
    ↓
Rows + Columns
    ↓
Keys
    ↓
Relationships
    ↓
SQL
    ↓
Queries
```

I also learned:

* A database manages data.
* A relational database organizes data into related structures.
* A table represents a concept.
* A row represents one record.
* A column represents a property.
* A primary key identifies a row.
* A foreign key helps connect tables.
* SQL is the language I use to communicate with a relational database.
* MySQL is an RDBMS, not the SQL language itself.
* SQL is largely declarative.
* Relational databases and MongoDB use different data-modeling approaches.
* Relationships between data are one of the most important ideas in relational databases.

Most importantly:

> **I am not learning SQL to memorize commands. I am learning how to think about structured, connected data and then use SQL to communicate that thinking to a database.**

---

# Next Lesson

## Lesson 02 — Tables, Rows & Columns

Now that I understand **why relational databases exist and how they think about data**, I am ready to actually start using MySQL.

In the next lesson, I will learn:

```text
Database
    ↓
CREATE DATABASE
    ↓
CREATE TABLE
    ↓
Columns
    ↓
Data Types
    ↓
Rows
    ↓
INSERT
```

This is where I will stop talking only about the mental model and start building my first actual SQL database.
