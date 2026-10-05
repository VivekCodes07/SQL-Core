# Lesson 1 — What Is a Relational Database?

## Why Am I Learning This?

I already understand the basic idea of a database because I have worked with MongoDB.

I know that applications need databases to store and retrieve information.

But relational databases require a different way of thinking.

With MongoDB, I naturally think in terms of:

```text
Documents
    ↓
Collections
    ↓
Embedded / Referenced Data
```

With relational databases, I need to think in terms of:

```text
Entities
    ↓
Tables
    ↓
Rows + Columns
    ↓
Relationships
    ↓
SQL
```

Before learning `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `JOIN`, and other SQL commands, I need to understand the structure those commands operate on.

### Goals of this lesson

I want to understand:

* What a database is
* What a relational database is
* What entities, tables, rows, and columns are
* Why data is separated into tables
* What Primary Keys are
* What Foreign Keys are
* How tables are related
* How relational databases represent real applications
* The difference between SQL and MySQL
* How relational thinking differs from MongoDB thinking
* How to reason about data before writing SQL

The main goal is to build this mental model:

```text
Real-World Application
        ↓
      Entities
        ↓
       Tables
        ↓
   Rows + Columns
        ↓
   Relationships
        ↓
    SQL Queries
```

> **Understand the data first. Write the query second.**

---

# 1. What Is a Database?

A database is a system used to **store, organize, and retrieve data**.

For example, an e-commerce application may need to store:

```text
Users
Products
Orders
Payments
Reviews
```

A simplified backend architecture looks like:

```text
User
  ↓
Frontend
  ↓
Backend
  ↓
Database
```

The backend communicates with the database to perform operations such as:

```text
Find a user
Create an order
Update a product
Find a user's orders
```

SQL is the language I will use to communicate with a relational database.

---

# 2. What Is a Relational Database?

A relational database organizes structured data into **tables** and allows those tables to be connected through **relationships**.

For an e-commerce application, I might have:

```text
Database
   │
   ├── users
   ├── products
   ├── orders
   ├── payments
   └── reviews
```

Each table represents a particular kind of entity:

```text
users     → users
products  → products
orders    → orders
payments  → payments
reviews   → reviews
```

The important idea is that these tables can be related.

For example:

```text
User
  ↓
Orders
```

A user can have multiple orders.

That connection between tables is a major part of the relational model.

---

# 3. Think About the Real World First

Before designing tables, I should identify the things that exist in the application.

Suppose I am building an online shopping application.

I might identify:

```text
User
Product
Order
Payment
Review
```

These are **entities**.

An entity is a real-world concept that I want to store information about.

For example:

```text
User
    ↓
name
email
password
created_at
```

and:

```text
Product
    ↓
name
price
stock
```

The database representation then becomes:

```text
User      → users
Product   → products
Order     → orders
Payment   → payments
Review    → reviews
```

This gives me an important database-design habit:

> **Start with the application and its entities, not with SQL syntax.**

---

# 4. Tables, Rows and Columns

Once I identify an entity, I need a structure for storing its data.

For users:

```text
users

┌─────┬─────────┬─────────────────────┐
│ id  │ name    │ email               │
├─────┼─────────┼─────────────────────┤
│ 101 │ Vivek   │ vivek@gmail.com     │
│ 102 │ Rahul   │ rahul@gmail.com     │
│ 103 │ Aman    │ aman@gmail.com      │
└─────┴─────────┴─────────────────────┘
```

There are three important concepts here.

### Table

A **table** stores data about a particular kind of entity.

```text
users
```

### Row

A **row** represents one record.

```text
101 | Vivek | vivek@gmail.com
```

So:

```text
1 row = 1 record
```

### Column

A **column** represents a type of information stored for each record.

```text
id
name
email
```

A useful mental model:

```text
Table
  │
  ├── Columns → what information is stored
  │
  └── Rows    → the actual records
```

---

# 5. Why Not Store Everything in One Big Table?

Suppose I store users and orders together:

```text
orders

┌──────┬────────┬───────────────────┬─────────┬───────┐
│ id   │ user   │ user_email        │ product │ total │
├──────┼────────┼───────────────────┼─────────┼───────┤
│ 9001 │ Vivek  │ vivek@gmail.com   │ Keyboard│ 2499  │
│ 9002 │ Vivek  │ vivek@gmail.com   │ Mouse   │  999  │
│ 9003 │ Vivek  │ vivek@gmail.com   │ Monitor │15000  │
└──────┴────────┴───────────────────┴─────────┴───────┘
```

The user's information is repeated.

If Vivek changes his email address, multiple rows may need to be updated.

This creates unnecessary duplication and can lead to inconsistent data.

Instead, I can separate the entities:

```text
users

┌─────┬────────┬───────────────────┐
│ id  │ name   │ email             │
├─────┼────────┼───────────────────┤
│ 101 │ Vivek  │ vivek@gmail.com   │
└─────┴────────┴───────────────────┘
```

and:

```text
orders

┌──────┬─────────┬───────┐
│ id   │ user_id │ total │
├──────┼─────────┼───────┤
│ 9001 │   101   │ 2499  │
│ 9002 │   101   │  999  │
│ 9003 │   101   │15000  │
└──────┴─────────┴───────┘
```

Now the order only needs:

```text
user_id = 101
```

to identify the user who placed it.

This leads to an important principle:

> **Separate different kinds of data and connect them through relationships.**

The more formal rules for reducing duplication will be covered later when I learn **normalization**.

---

# 6. Primary Keys

If a table contains many rows, I need a reliable way to uniquely identify each row.

Consider:

```text
users

┌─────┬────────┐
│ id  │ name   │
├─────┼────────┤
│ 101 │ Vivek  │
│ 102 │ Rahul  │
│ 103 │ Aman   │
└─────┴────────┘
```

The `id` identifies each user.

This can be the table's **Primary Key**.

```text
users
  │
  └── id
       ↓
   Primary Key
```

### Mental model

> **Primary Key = identity of a row.**

For example:

```text
101 → Vivek
102 → Rahul
103 → Aman
```

A Primary Key uniquely identifies a record within its table.

I will learn the actual MySQL syntax for defining Primary Keys later.

---

# 7. Foreign Keys and Relationships

Now I need to connect the `orders` table to the `users` table.

Consider:

```text
users

┌─────┬────────┐
│ id  │ name   │
├─────┼────────┤
│ 101 │ Vivek  │
│ 102 │ Rahul  │
└─────┴────────┘
```

and:

```text
orders

┌──────┬─────────┬───────┐
│ id   │ user_id │ total │
├──────┼─────────┼───────┤
│ 9001 │   101   │ 2499  │
│ 9002 │   102   │  999  │
│ 9003 │   101   │ 1500  │
└──────┴─────────┴───────┘
```

The relationship is:

```text
orders.user_id  ──────────►  users.id
   Foreign Key               Primary Key
```

So:

* `users.id` identifies a user.
* `orders.user_id` references that user.
* Multiple orders can reference the same user.

The relationship can be visualized as:

```text
┌───────────────────┐
│      users        │
├───────────────────┤
│ id        (PK)    │
│ name              │
│ email             │
└───────────────────┘
          ▲
          │
          │ references
          │
┌───────────────────┐
│      orders       │
├───────────────────┤
│ id        (PK)    │
│ user_id   (FK)    │
│ total             │
└───────────────────┘
```

The key relationship is:

```text
orders.user_id  ──────────►  users.id
```

This is a **one-to-many relationship**:

```text
One User
   │
   ├── Order 9001
   ├── Order 9003
   └── Order 9010
```

The important idea is:

> **Primary Keys identify records. Foreign Keys connect records between tables.**

---

# 8. A Real Backend Example

Now I can connect the database model to backend development.

Suppose an e-commerce backend receives:

```http
POST /orders
```

with:

```json
{
  "userId": 101,
  "productId": 501,
  "quantity": 2
}
```

The database might contain:

```text
users
products
orders
order_items
payments
```

The relationships could look like:

```text
users
  │
  │ user_id
  ↓
orders
  │
  │ order_id
  ↓
order_items
  │
  │ product_id
  ↓
products
```

Now the database represents the structure of the application.

If I want to answer:

> "Show Vivek's orders and the products in those orders."

I need to follow the relationship:

```text
users
  ↓
orders
  ↓
order_items
  ↓
products
```

Later, SQL `JOIN`s will allow me to query across these tables.

This is why understanding relationships comes before learning JOIN syntax.

---

# 9. How I Should Think About Database Design

Suppose someone asks:

> "Build the database for an online shopping application."

I should not immediately start writing SQL.

I should reason through the problem first.

### Step 1 — Identify entities

```text
User
Product
Category
Order
Order Item
Payment
Review
```

### Step 2 — Identify information

For example:

```text
User
    ↓
id
name
email

Product
    ↓
id
name
price
stock
```

### Step 3 — Identify unique identities

```text
users.id
products.id
orders.id
```

### Step 4 — Identify relationships

```text
User
  ↓
Orders

Order
  ↓
Order Items

Order Item
  ↓
Product
```

### Step 5 — Represent relationships with keys

```text
orders.user_id  ───────►  users.id
```

So my design process becomes:

```text
Understand the application
        ↓
Identify entities
        ↓
Design tables
        ↓
Choose columns
        ↓
Choose Primary Keys
        ↓
Define relationships
        ↓
Write SQL
```

---

# 10. SQL vs MySQL

I also need to understand the difference between SQL and MySQL.

## SQL

SQL stands for:

**Structured Query Language**

It is a language used to communicate with relational databases.

For example:

```sql
SELECT * FROM users;
```

This is SQL.

## MySQL

MySQL is a **Relational Database Management System (RDBMS)**.

It is software that stores data and executes SQL queries.

The relationship is:

```text
SQL
 │
 │ language
 ↓
MySQL
 │
 │ manages
 ↓
Database
```

So:

> **SQL is the language. MySQL is the database system I will use to practice that language.**

---

# 11. MySQL Database I Will Use

For this learning journey, I created:

```text
sql_learning
```

This is my dedicated SQL learning database.

I will build it gradually as I learn.

Early lessons may use simple tables:

```text
users
products
```

Later, I can introduce:

```text
categories
orders
order_items
payments
reviews
```

The database will grow alongside the lessons:

```text
Basic SQL
    ↓
Filtering
    ↓
Aggregation
    ↓
JOINs
    ↓
Database Design
    ↓
Indexes
    ↓
Transactions
    ↓
Backend Integration
```

This makes the database itself part of the learning process.

---

# 12. The Mental Shift From MongoDB

Because I already know MongoDB, I need to be intentional about changing my mental model.

MongoDB naturally encourages me to think in terms of:

```text
Documents
    ↓
Collections
    ↓
Embedded / Referenced Data
```

Relational databases encourage me to think in terms of:

```text
Entities
    ↓
Tables
    ↓
Rows
    ↓
Relationships
```

So instead of only asking:

```text
What should this document look like?
```

I also need to ask:

```text
What entities exist?

Which table represents each entity?

What information belongs to each table?

What uniquely identifies each row?

How are the tables related?
```

I should not think:

> "SQL is MongoDB with different syntax."

The data model itself is different.

That difference is what I want to understand.

---

# 13. How I Should Think Before Writing SQL

Suppose I receive this requirement:

> "Show all orders placed by Vivek."

I should first reason about the data:

```text
I need orders
      ↓
Orders are stored in orders
      ↓
Orders belong to users
      ↓
I need to identify Vivek
      ↓
Vivek is stored in users
      ↓
users.id connects to orders.user_id
```

Now I understand the path through the data.

Only then should I write the SQL.

This habit will become increasingly important as queries become more complex.

> **Understand the data first. Write the query second.**

---

# 14. What I Learned

After completing this lesson, I should be able to explain:

* What a database is
* What a relational database is
* What an entity represents
* What a table represents
* What a row represents
* What a column represents
* Why data is separated into tables
* What a Primary Key is
* What a Foreign Key is
* How tables are related
* What a one-to-many relationship means
* Why Foreign Keys can contain duplicate values
* How a backend application's data can be represented using tables
* The difference between SQL and MySQL
* How relational thinking differs from MongoDB thinking
* Why I should understand the data before writing SQL

Most importantly:

> **A relational database is a structured representation of real-world entities and the relationships between them.**

---

# 15. What I Should Be Able to Visualize

Given an online shopping application, I should be able to visualize something like:

```text
Online Shopping Application
            │
            ├── Users
            ├── Products
            ├── Categories
            ├── Orders
            ├── Order Items
            ├── Payments
            └── Reviews
```

And understand relationships such as:

```text
users
  │
  │ user_id
  ↓
orders
  │
  │ order_id
  ↓
order_items
  │
  │ product_id
  ↓
products
```

And at the key level:

```text
orders.user_id  ──────────►  users.id
   Foreign Key               Primary Key
```

I should be able to look at this structure and understand what the data represents **before writing a query**.

---

# Final Mental Model

The complete mental model I want to take from this lesson is:

```text
REAL WORLD
    ↓
ENTITIES
    ↓
TABLES
    ↓
ROWS + COLUMNS
    ↓
PRIMARY KEYS
    ↓
RELATIONSHIPS
    ↓
FOREIGN KEYS
    ↓
SQL
```

When I receive a database problem:

```text
Don't start with the query.

Start with the data.
```

That is the relational mindset I want to build before moving to the next lesson.
