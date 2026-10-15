# Lesson 07 — Database Commands in MySQL

## Why Am I Learning This?

Before I can create tables, insert records, or retrieve data, I need a database in which all that data will live.

Think about an e-commerce application like Amazon. It needs to store information about users, products, orders, payments, and deliveries. These tables need a database to belong to.

Before working with those tables, I should know how to:

- Create a database for my application.
- See which databases already exist.
- Select the database I want to work with.
- Check which database is currently selected.
- Delete a database when it is no longer needed.

These operations may look simple, but they are part of the foundation of working with databases in backend development.

I also want to understand one important thing: **MySQL commands do not all perform the same kind of operation.** Some create databases, some select them, and others permanently remove them.

---

## 1. Understanding Where a Database Fits

Before writing commands, I want to understand what I am actually working with.

```text
MySQL Server
│
├── sql_learning
│   ├── users
│   ├── products
│   └── orders
│
├── ecommerce_app
│   ├── customers
│   ├── payments
│   └── deliveries
│
└── company_db
    ├── employees
    └── departments
```

This is a conceptual view of a MySQL server. It can contain multiple databases, and each database can contain multiple tables.

For example, `ecommerce_app` might contain all the tables required by an e-commerce application.

When I create a database, I am creating a place to organize related database objects. I am not automatically creating tables or inserting data.

---

## 2. Creating a Database — `CREATE DATABASE`

Suppose I am starting a new backend project and need a database named `ecommerce_app`.

I can create it using:

```sql
CREATE DATABASE ecommerce_app;
```

### What does this command mean?

- `CREATE` tells MySQL that I want to create something.
- `DATABASE` specifies what I want to create.
- `ecommerce_app` is the name I have chosen.

When I execute this command successfully, MySQL creates the database.

However, the database will initially be empty. I still need to create tables inside it.

### What if the database already exists?

If I execute the same command again, MySQL will return an error because a database with that name already exists.

To avoid that error, I can use:

```sql
CREATE DATABASE IF NOT EXISTS ecommerce_app;
```

This tells MySQL to create the database only if it does not already exist.

I will often see this form in setup scripts because it makes them safer to run more than once.

**Important:** `IF NOT EXISTS` prevents the duplicate-database error. It does not reset or recreate an existing database.

---

## 3. Viewing Available Databases — `SHOW DATABASES`

After creating a database, I may want to see whether it exists.

```sql
SHOW DATABASES;
```

This command lists the databases that my MySQL account is allowed to see.

The output might look something like this:

```text
+--------------------+
| Database           |
+--------------------+
| ecommerce_app      |
| information_schema |
| mysql              |
| performance_schema |
| sql_learning       |
+--------------------+
```

The output above is only an example; the databases on my computer may be different.

I may also see system databases such as `mysql`, `information_schema`, and `performance_schema`. These are used by MySQL for internal management, metadata, and performance information.

I should not delete system databases just because I do not recognize them.

### What have I learned here?

`CREATE DATABASE` creates a database, whereas `SHOW DATABASES` lists databases.

Neither command selects a database for me to work with.

That is the job of `USE`.

---

## 4. Selecting a Database — `USE`

Imagine that my MySQL server contains five databases. I want to create tables inside `ecommerce_app`.

First, I need to select it:

```sql
USE ecommerce_app;
```

If the command succeeds, MySQL responds with:

```text
Database changed
```

This means that `ecommerce_app` is now the selected database for my current session.

I can think of it like choosing the project folder I want to work in before creating files. The analogy is not exact, but it helps me understand why selecting the right database matters.

### What happens if I forget `USE`?

Suppose I run:

```sql
CREATE TABLE products (
    id INT,
    name VARCHAR(100)
);
```

If I have selected `ecommerce_app`, the table will be created there.

But if no database is selected, MySQL will normally report that no database is selected.

This is why I should check which database I am working in before running table-related commands.

### Does `USE` create a database?

No.

```sql
USE ecommerce_app;
```

only selects an existing database. If `ecommerce_app` does not exist, MySQL will return an error.

The database must be created first.

---

## 5. Checking the Currently Selected Database

Sometimes I may forget which database I selected, especially when working with several projects.

I can check it using:

```sql
SELECT DATABASE();
```

If I have selected `ecommerce_app`, the result will look like this:

```text
+--------------------+
| DATABASE()         |
+--------------------+
| ecommerce_app      |
+--------------------+
```

If I have not selected a database, the result is `NULL`.

Here, `SELECT` is an SQL statement, and `DATABASE()` is a function that returns the name of the current database.

I do not need to memorize the internal details yet. I just need to know that this command is a useful way to verify my current working database.

---

## 6. Deleting a Database — `DROP DATABASE`

Suppose I created a database while experimenting, and now I no longer need it.

I can remove it using:

```sql
DROP DATABASE test_database;
```

This removes the database and its tables and data.

That makes `DROP DATABASE` very different from simply selecting another database.

### Avoid deleting a database accidentally

If I am unsure whether the database exists, I can use:

```sql
DROP DATABASE IF EXISTS test_database;
```

This avoids an error if the database does not exist.

However, it does **not** make the operation safe. If the database does exist, MySQL will still delete it.

Before running a `DROP DATABASE` command, I should always verify the database name and make sure I do not need its data.

I should never run a destructive command against a real project database just to experiment.

---

## 7. Understanding the Complete Workflow

Now I want to connect the commands instead of learning them as isolated pieces.

Suppose I am setting up a new database for my application.

```text
Start
  |
  v
Create the database
  |
  v
Check available databases
  |
  v
Select the required database
  |
  v
Verify the selected database
  |
  v
Create tables and work with data
```

The SQL commands for these steps are:

```sql
CREATE DATABASE IF NOT EXISTS ecommerce_app;

SHOW DATABASES;

USE ecommerce_app;

SELECT DATABASE();
```

I can execute these statements one by one in the MySQL command-line client.

Notice that the statements do different jobs:

- `CREATE DATABASE` creates the database if needed.
- `SHOW DATABASES` lists available databases.
- `USE` selects the database.
- `SELECT DATABASE()` verifies the selection.

I do not need to run `DROP DATABASE` as part of the normal setup workflow. It is included because I also need to understand how database deletion works.

---

## 8. What Is the Difference Between `DROP DATABASE` and `DROP TABLE`?

I have already learned that a database can contain several tables. This means that deleting a database and deleting a table are not the same operation.

| Command | What it removes |
|---|---|
| `DROP DATABASE ecommerce_app;` | The database and its tables |
| `DROP TABLE products;` | The specified table and its data |
| `USE ecommerce_app;` | Nothing; it selects the database |
| `SHOW DATABASES;` | Nothing; it lists databases |

For example, if `ecommerce_app` contains `users`, `products`, and `orders`, dropping the `products` table removes that table, but it does not delete the entire database.

Dropping the database removes the entire database and the objects it contains.

This distinction is important because the commands that create and delete database objects can have permanent consequences.

---

## 9. MySQL Command-Line Practice

I will practise these commands using the MySQL command-line client I already have installed.

First, I can connect to MySQL using my usual login command. Once I see the `mysql>` prompt, I can enter SQL statements.

### Step 1 — Check the databases

```sql
SHOW DATABASES;
```

I should inspect the output and identify `sql_learning`, the database I have already been using.

### Step 2 — Select my learning database

```sql
USE sql_learning;
```

Expected response:

```text
Database changed
```

### Step 3 — Verify the selection

```sql
SELECT DATABASE();
```

The result should show `sql_learning`.

### Step 4 — Create a separate practice database

```sql
CREATE DATABASE IF NOT EXISTS command_practice;
```

This creates a separate database for practising database commands without needing to delete my existing learning database.

### Step 5 — Confirm that it exists

```sql
SHOW DATABASES;
```

I should now see `command_practice` in the output, assuming the command succeeded and my account can see it.

### Step 6 — Select the practice database

```sql
USE command_practice;

SELECT DATABASE();
```

The second statement should return `command_practice`.

I have now practised creating, listing, selecting, and checking databases without modifying my existing lesson tables.

### Optional cleanup

If I am absolutely sure I no longer need the practice database, I can remove it:

```sql
DROP DATABASE command_practice;
```

I should only run this cleanup after checking that I have selected or identified the correct database and that it contains nothing I need.

---

## 10. Commands I Should Remember

| Command | Purpose |
|---|---|
| `CREATE DATABASE name;` | Create a database |
| `CREATE DATABASE IF NOT EXISTS name;` | Create it only if it does not exist |
| `SHOW DATABASES;` | List databases I can see |
| `USE name;` | Select a database |
| `SELECT DATABASE();` | Check the selected database |
| `DROP DATABASE name;` | Delete a database |
| `DROP DATABASE IF EXISTS name;` | Delete it if it exists, without an error if it is absent |

In these examples, `name` is a placeholder. I should replace it with an actual database name rather than typing the word `name` literally.

---

## 11. What Have I Learned?

After this lesson, I should understand that:

- A MySQL server can contain multiple databases.
- A database can organize related tables and other database objects.
- Creating a database does not automatically create tables.
- `SHOW DATABASES` lists databases, while `USE` selects one.
- `SELECT DATABASE()` helps me verify the current selection.
- `DROP DATABASE` is destructive and removes the database and its contents.
- `IF NOT EXISTS` and `IF EXISTS` help avoid specific errors, but they do not make destructive operations harmless.

The goal is not simply to remember six commands. I want to understand what each command changes, what it leaves untouched, and why I would use it when setting up a backend application.

**Next lesson:** Table Operations — creating tables, inserting records, altering table structures, and dropping tables.