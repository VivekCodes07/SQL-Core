# SQL-Mastery

This repository is my personal journey of learning **SQL from the ground up using MySQL**.

I already have experience with **MongoDB**, so I understand the basic idea of working with databases, storing data, querying it, and building applications around it.

Now I want to properly understand the **relational side of databases**.

That means learning how tables are structured, how relationships work, why constraints exist, how JOINs connect data, how aggregation works, how databases are designed, how transactions maintain consistency, how indexes improve performance, and how SQL fits into backend development.

The goal is not to memorize SQL syntax.

The goal is to understand **how to think about relational data and write SQL on my own.**

---

## Why Am I Learning SQL?

I am focusing on **backend development**, so I don't want to depend on only one type of database.

MongoDB has taught me how to think in terms of:

```text
Documents
   ↓
Collections
   ↓
Embedded / Referenced Data
   ↓
Queries
   ↓
Application Data
```

Now I want to understand the relational model:

```text
Tables
   ↓
Rows & Columns
   ↓
Relationships
   ↓
SQL Queries
   ↓
Useful Data
```

The important difference for me is not just syntax.

I want to understand **why relational databases are designed this way** and how I should reason about the data before writing a query.

Eventually, I want my thinking process to look something like this:

```text
What data do I need?
        ↓
Which table contains it?
        ↓
How are the tables related?
        ↓
Do I need a JOIN?
        ↓
Do I need filtering?
        ↓
Do I need aggregation?
        ↓
Do I need a subquery or CTE?
        ↓
Is the query correct?
        ↓
Will the query perform well?
```

That is the skill I am actually trying to build.

---

## What I Want to Understand

Throughout this journey, I want to go beyond simply making queries work.

I want to understand:

* How relational databases store data
* How tables represent real-world entities
* How relationships between tables work
* Why primary keys and foreign keys exist
* How constraints protect data
* How SQL queries are executed
* How JOINs actually combine data
* How aggregation helps answer questions about data
* How to design a database properly
* Why normalization exists
* When denormalization makes sense
* How subqueries and CTEs work
* How window functions solve complex problems
* How indexes affect query performance
* How transactions maintain consistency
* How concurrency can create problems
* How SQL is used inside backend applications

---

# My Setup

| Tool          | Choice         |
| ------------- | -------------- |
| OS            | Windows        |
| Editor        | VS Code        |
| Database      | MySQL          |
| SQL Extension | SQLTools       |
| Database Name | `sql_learning` |

I am using **MySQL** as the database system for this entire learning journey.

One important distinction I want to keep clear:

```text
SQL
↓
The language I am learning

MySQL
↓
The database management system I am using
to execute SQL
```

SQL is the language.

MySQL is the system I am using to work with that language.

---

# How I Am Learning

I am following a **lesson-by-lesson approach**.

For every important concept, I want to understand it in this order:

```text
WHY
 ↓
WHAT
 ↓
HOW
 ↓
EXECUTION
 ↓
PRACTICE
```

### WHY

Why does this concept exist?

What problem does it solve?

### WHAT

What exactly is it?

What are its rules and important parts?

### HOW

How do I use it?

What does the syntax look like?

### EXECUTION

What actually happens when MySQL executes it?

### PRACTICE

Can I write and modify the SQL myself without blindly copying it?

I will experiment with queries, intentionally make mistakes, observe the results, and keep my notes in my own words.

The purpose of this repository is not to create perfect documentation.

It is to create a **record of what I actually understood.**

---

# Repository Structure

```text
SQL-Mastery/
│
├── README.md
├── .gitignore
│
├── database/
│   ├── README.md
│   ├── schema.sql
│   └── seed.sql
│
├── 01-Relational-Database-Foundations/
│   ├── L01-What-Is-a-Relational-Database/
│   │   ├── README.md
│   │   └── playground.sql
│   │
│   ├── L02-Tables-Rows-and-Columns/
│   │   ├── README.md
│   │   └── playground.sql
│   │
│   └── ...
│
├── 02-SQL-Fundamentals/
│   └── ...
│
├── 03-Filtering-and-Expressions/
│   └── ...
│
└── ...
```

Each lesson follows the same basic structure:

```text
Lxx-Lesson-Name/
├── README.md
└── playground.sql
```

### README.md

Contains my understanding of the lesson.

I use it for:

* Concepts
* WHY behind the concept
* Syntax
* Query anatomy
* Execution flow
* Examples
* Common mistakes
* Important rules
* Things I learned

### playground.sql

This is where I actually write and execute SQL.

Instead of only reading examples, I use this file to:

* Write queries
* Modify queries
* Experiment
* Break things intentionally
* Test different conditions
* Observe results

The `README.md` explains what I understand.

The `playground.sql` shows what I actually practiced.

---

# Learning Roadmap

## 01 — Relational Database Foundations

Before writing complex SQL, I want to understand the system SQL is working with.

* What is a database?
* What is a relational database?
* Tables, rows, and columns
* Entities and attributes
* Relationships
* Relational databases vs NoSQL
* Primary keys
* Foreign keys
* `NULL`
* Constraints
* Referential integrity

---

## 02 — SQL Fundamentals

Learn how to create and manipulate relational data.

* `CREATE DATABASE`
* `CREATE TABLE`
* Data types
* `INSERT`
* `SELECT`
* `UPDATE`
* `DELETE`
* `ORDER BY`
* `LIMIT`
* `OFFSET`
* `DISTINCT`

---

## 03 — Filtering and Expressions

Learn how to control exactly which data I want.

* `WHERE`
* Comparison operators
* `AND`
* `OR`
* `NOT`
* `BETWEEN`
* `IN`
* `LIKE`
* `IS NULL`
* Column aliases
* Expressions
* `CASE`

---

## 04 — Aggregation

Move from retrieving individual rows to answering questions about groups of data.

* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`
* `GROUP BY`
* `HAVING`
* `WHERE` vs `HAVING`

---

## 05 — JOINs and Relationships

Understand one of the most important parts of relational SQL.

* Why JOINs exist
* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* `CROSS JOIN`
* `SELF JOIN`
* Multiple JOINs
* JOIN + filtering
* JOIN + aggregation
* Understanding JOIN conditions

The goal here is not just to memorize JOIN syntax.

I want to understand **how rows from different tables are actually matched together.**

---

## 06 — Database Design

Learn how to design relational databases instead of only querying them.

* One-to-one relationships
* One-to-many relationships
* Many-to-many relationships
* Junction tables
* Normalization
* First Normal Form
* Second Normal Form
* Third Normal Form
* Denormalization
* Real-world schema design
* Choosing relationships and constraints

---

## 07 — Intermediate SQL

Learn techniques for solving more complex problems.

* Subqueries
* Correlated subqueries
* `EXISTS`
* `NOT EXISTS`
* `UNION`
* `UNION ALL`
* CTEs
* Views

---

## 08 — Advanced SQL

Learn powerful SQL features used for analytical and complex queries.

* Window functions
* `OVER`
* `PARTITION BY`
* `ROW_NUMBER`
* `RANK`
* `DENSE_RANK`
* `LAG`
* `LEAD`
* Running totals
* Ranking problems
* Top-N queries
* Advanced analytical queries

---

## 09 — MySQL

Now go deeper into the specific database system I am using.

* MySQL data types
* `AUTO_INCREMENT`
* `UNSIGNED`
* `ENUM`
* JSON data
* MySQL functions
* MySQL-specific features
* MySQL behavior and conventions

The goal here is to understand the difference between **general SQL knowledge** and **MySQL-specific knowledge**.

---

## 10 — Indexes and Performance

Learn what happens when the database becomes large.

* Why indexes exist
* How indexes work
* B-Tree indexes
* Unique indexes
* Composite indexes
* Index selectivity
* `EXPLAIN`
* Query execution
* Query optimization
* When indexes help
* When indexes can hurt
* N+1 problem

I don't just want to know how to write a query.

I also want to ask:

> **Is this query efficient?**

---

## 11 — Transactions and Concurrency

Understand how databases maintain consistency when multiple operations or users are involved.

* Transactions
* `COMMIT`
* `ROLLBACK`
* ACID
* Isolation levels
* Locks
* Race conditions
* Deadlocks
* Concurrency problems

This will become especially important when I start connecting SQL with backend applications.

---

## 12 — SQL with Node.js

Connect everything I have learned with backend development.

* Connecting Node.js to MySQL
* MySQL drivers
* Connection pools
* Parameterized queries
* SQL injection
* CRUD APIs
* Transactions from Node.js
* Pagination
* Filtering
* Sorting
* Searching
* Error handling

The goal is to understand what actually happens between:

```text
Client
  ↓
API
  ↓
Node.js
  ↓
SQL Query
  ↓
MySQL
  ↓
Result
  ↓
Node.js
  ↓
API Response
  ↓
Client
```

---

## 13 — ORM and Query Builders

Only after becoming comfortable with raw SQL.

I don't want an ORM to hide SQL from me before I understand SQL itself.

Topics:

* Why ORMs exist
* Prisma
* Prisma schema
* CRUD
* Relationships
* Transactions
* Query builders
* Raw SQL vs ORM
* When to use an ORM
* When raw SQL is useful

The idea is simple:

```text
Understand SQL first
        ↓
Understand databases
        ↓
Understand relationships
        ↓
Understand performance
        ↓
Then use an ORM
```

---

# Database

I am keeping one main database for this learning journey:

```text
sql_learning
```

The database will grow as I progress through the lessons.

Instead of creating completely unrelated databases for every concept, I want to gradually build something closer to a **real-world application database**.

Eventually, I want to work with tables such as:

```text
users
products
categories
orders
order_items
payments
```

With relationships such as:

```text
users
  │
  └── orders
        │
        └── order_items
                │
                └── products
```

This will give me realistic data to work with when I reach:

* JOINs
* Aggregation
* Database design
* Subqueries
* CTEs
* Transactions
* Indexes
* Query optimization
* Backend integration

I want the database itself to become part of my learning.

---

# My Learning Philosophy

There is one thing I want to avoid throughout this journey:

```text
See query
   ↓
Memorize query
   ↓
Copy query
   ↓
Forget query
```

Instead:

```text
Understand the problem
        ↓
Understand the data
        ↓
Understand the relationship
        ↓
Think about the required result
        ↓
Build the query
        ↓
Execute it
        ↓
Understand the result
        ↓
Modify and experiment
```

If I cannot explain **why** a query works, then I haven't properly learned it yet.

---

# My Goal

By the end of this repository, I don't want to say:

> "I completed an SQL course."

I want to be able to say:

> **"I can look at a relational database, understand its structure, figure out where the data I need is stored, understand how the tables are related, and write the SQL required to get the result."**

And beyond writing queries, I want to understand what happens around them:

```text
Database Design
       ↓
Relationships
       ↓
SQL Query
       ↓
Query Execution
       ↓
Indexes
       ↓
Performance
       ↓
Transactions
       ↓
Backend Integration
```

That is the level of SQL knowledge I am aiming for.

---

# Current Progress

```text
Database       : MySQL
Database Name  : sql_learning
Current Stage  : Relational Database Foundations
Current Lesson : L01 — What Is a Relational Database?
```

This repository will evolve as I learn.

The roadmap may change when I discover concepts that need to be moved, added, or understood earlier.

---

# Learning Rule

> **Don't memorize the query. Understand why the query works.**

```text
Syntax is something I can look up.

Understanding is something I have to build.
```
