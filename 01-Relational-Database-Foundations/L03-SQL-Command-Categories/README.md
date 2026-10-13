# Lesson 03 — SQL Command Categories

## Why Am I Learning This?

I already understand what a relational database is, and I know that data is organized into tables containing rows and columns.

But a database is not useful just because it stores data. I also need a way to:

- Create databases and tables.
- Insert records into tables.
- Read the information I have stored.
- Change existing records.
- Remove records when necessary.
- Control who can access the database.
- Manage transactions so that related operations behave correctly.

SQL gives me commands to perform these operations.

However, SQL has many commands, and memorizing them one by one without understanding their purpose would make learning confusing.

That is why I am learning **SQL command categories** first.

Instead of remembering SQL as a collection of unrelated commands, I want to understand the different jobs those commands perform.

## What Am I Going to Learn?

By the end of this lesson, I want to understand:

1. What SQL commands are and why I need them.
2. The five commonly taught SQL command categories: DDL, DML, DQL, DCL and TCL.
3. Which commands belong to each category.
4. The difference between changing a table's structure and changing its data.
5. Why `SELECT`, `INSERT`, `UPDATE` and `DELETE` serve different purposes.
6. How these categories fit into the work I will do with MySQL.

---

## 1. First, What Is an SQL Command?

SQL stands for **Structured Query Language**. It is the language I use to communicate with a relational database management system such as MySQL.

Think about my school-management database.

I might want to create a `students` table, add a student, retrieve a student's information, or update their email address.

Each operation requires me to give MySQL an instruction.

For example:

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT
);
```

This instruction tells MySQL to create a table named `students` with three columns.

Another instruction:

```sql
SELECT * FROM students;
```

This tells MySQL to retrieve all columns and rows from the `students` table.

Both are SQL commands, but they do completely different jobs.

That leads to the main idea of this lesson:

**I can group SQL commands according to the purpose they serve.**

## 2. The Big Picture — Five SQL Command Categories

The five commonly taught categories are:

```text
SQL COMMANDS
│
├── DDL — Data Definition Language
│   └── Defines or changes database structure
│
├── DML — Data Manipulation Language
│   └── Adds, changes or removes data
│
├── DQL — Data Query Language
│   └── Retrieves data
│
├── DCL — Data Control Language
│   └── Controls database permissions
│
└── TCL — Transaction Control Language
    └── Manages transactions
```

These categories help me answer one important question whenever I encounter a new SQL command:

**What job is this command doing?**

Let's understand each category individually.

---

## 3. DDL — Data Definition Language

### Why do I need DDL?

Before I can store student records, I need to define where those records will go.

I need to create a database and tables. Later, I might need to add a column, change a table's structure, or remove a table that is no longer needed.

These operations deal with the **structure of the database**, rather than individual records.

That is the job of DDL.

DDL stands for **Data Definition Language**.

### Common DDL commands

| Command | Purpose |
|---|---|
| `CREATE` | Creates a database object, such as a database or table |
| `ALTER` | Changes the structure of an existing object |
| `DROP` | Removes a database object |
| `TRUNCATE` | Removes all rows from a table while keeping the table itself |

### Example 1 — CREATE

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT
);
```

I am defining the structure of the `students` table.

At this point, I have created the table, but I have not inserted any student records.

### Example 2 — ALTER

Suppose I later decide that I also want to store student email addresses.

```sql
ALTER TABLE students
ADD email VARCHAR(150);
```

I have changed the structure by adding a new column.

### Example 3 — DROP

```sql
DROP TABLE students;
```

This removes the table itself, including its stored records and structure.

**Important:** I should not execute this command on a table containing data I want to keep. Dropping a table is not the same as deleting a single record.

### What I should remember about DDL

DDL deals with database structure.

```text
Before:
students
├── id
├── name
└── age

After ALTER TABLE:
students
├── id
├── name
├── age
└── email
```

I am changing the design of the table, not simply editing one student's details.

---

## 4. DML — Data Manipulation Language

### Why do I need DML?

Creating a table gives me a place to store data, but it does not fill the table with records.

Once the table exists, I need to insert new students, update their details, or remove records when necessary.

These operations deal with the **data stored inside tables**.

DML stands for **Data Manipulation Language**.

### Common DML commands

| Command | Purpose |
|---|---|
| `INSERT` | Adds new records |
| `UPDATE` | Changes existing records |
| `DELETE` | Removes selected records |

### Example 1 — INSERT

```sql
INSERT INTO students (id, name, age)
VALUES (1, 'John Cena', 21);
```

I am adding a new student record to the existing table.

The table's structure stays the same.

### Example 2 — UPDATE

```sql
UPDATE students
SET age = 22
WHERE id = 1;
```

I am changing the age of the student whose ID is `1`.

The `WHERE` condition identifies which record should be updated. Without a `WHERE` condition, this statement can update every row in the table.

### Example 3 — DELETE

```sql
DELETE FROM students
WHERE id = 1;
```

I am removing the record belonging to the student whose ID is `1`.

The table itself remains available, and its columns do not disappear.

### What I should remember about DML

DML deals with the records stored inside a table.

```text
students
+----+--------------+-----+
| id | name         | age |
+----+--------------+-----+
|  1 | John Cena    |  21 |
|  2 | Roman Reigns |  20 |
+----+--------------+-----+
```

If I update a student's age, I change a value in a record.

If I insert a student, I add a record.

If I delete a student, I remove a record.

I am not redefining the table's columns.

---

## 5. DQL — Data Query Language

### Why do I need DQL?

Suppose my school-management database contains thousands of student records.

I might want to display all students, find one particular student, or retrieve only the names and ages of students.

I need a way to ask the database questions without changing the stored records.

That is the job commonly associated with DQL.

DQL stands for **Data Query Language**.

### The main command — SELECT

```sql
SELECT * FROM students;
```

This retrieves every column and every row from the `students` table.

If I only want names and ages:

```sql
SELECT name, age
FROM students;
```

MySQL returns only those two columns.

### What makes SELECT different?

Compare these commands:

```sql
INSERT INTO students (id, name, age)
VALUES (3, 'Cody Rhodes', 22);
```

```sql
SELECT name, age
FROM students;
```

The first command adds a record.

The second command retrieves information.

A `SELECT` query does not modify the stored rows merely because it displays them.

### What I should remember about DQL

DQL is about **reading data**.

I will explore `SELECT` in detail in Lesson 09, after learning the foundational MySQL topics.

---

## 6. DCL — Data Control Language

### Why do I need DCL?

Imagine a database used by a school.

The administrator may need permission to create tables and manage records. A teacher might only need permission to view student information.

Giving every database user unrestricted access would be a poor security decision.

I need a way to manage what users are allowed to do.

That is the purpose of DCL.

DCL stands for **Data Control Language**.

### Common DCL commands

| Command | Purpose |
|---|---|
| `GRANT` | Gives specified privileges to a database user |
| `REVOKE` | Removes specified privileges |

For example, a database administrator can grant a user permission to read a particular table.

```sql
GRANT SELECT
ON school_management.students
TO 'teacher_user'@'localhost';
```

This is an illustrative MySQL permissions example. The user must exist, and the command requires appropriate privileges to execute.

The statement grants the specified user permission to run `SELECT` queries against that table.

To remove that permission:

```sql
REVOKE SELECT
ON school_management.students
FROM 'teacher_user'@'localhost';
```

The exact permissions available depend on the database system and how the user is configured.

### What I should remember about DCL

DCL is about **permissions and access control**.

I do not need to practise granting permissions in my learning database right now. I first want to become comfortable with basic SQL queries and table operations.

---

## 7. TCL — Transaction Control Language

### Why do I need TCL?

Some database operations should be treated as one logical unit.

Imagine transferring ₹1,000 from one bank account to another.

Two things must happen:

1. ₹1,000 must be deducted from the sender.
2. ₹1,000 must be added to the receiver.

What if the first operation succeeds but the second fails?

I do not want the database to leave the transfer half-completed.

Transactions help me group related operations so that I can commit them together or roll them back when appropriate.

TCL stands for **Transaction Control Language**.

### Common TCL commands

| Command | Purpose |
|---|---|
| `START TRANSACTION` | Begins a transaction |
| `COMMIT` | Makes the transaction's changes permanent |
| `ROLLBACK` | Undoes uncommitted transactional changes |
| `SAVEPOINT` | Creates a point within a transaction to which I can roll back |

### Example — COMMIT and ROLLBACK

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

COMMIT;
```

This illustrates a transaction that transfers money between two accounts.

If I discover an error before committing, I can use:

```sql
ROLLBACK;
```

That can undo the uncommitted changes in the current transaction.

The actual behavior depends on the storage engine and transaction configuration. In MySQL, transactional tables such as InnoDB support this workflow.

### What I should remember about TCL

TCL is about **controlling transactions**, not defining table structures or retrieving records.

I will study transactions and ACID properties in Lesson 27, when I move into backend SQL topics.

---

## 8. The Most Important Difference — Structure vs Data

This is the distinction I want to understand before memorizing any command.

Consider the following operations:

| What I want to do | Category | Command |
|---|---|---|
| Create a `students` table | DDL | `CREATE` |
| Add an `email` column | DDL | `ALTER` |
| Add a new student | DML | `INSERT` |
| Change a student's age | DML | `UPDATE` |
| Remove a particular student | DML | `DELETE` |
| Display student names | DQL | `SELECT` |
| Give a user read permission | DCL | `GRANT` |
| Confirm a transaction | TCL | `COMMIT` |

A useful mental model is:

```text
I want to work with my database
│
├── Its structure
│   └── DDL
│
├── Its stored records
│   ├── Add, change or remove records → DML
│   └── Retrieve records              → DQL
│
├── User permissions
│   └── DCL
│
└── Transaction boundaries
    └── TCL
```

The distinction between DDL and DML is especially important.

Creating a column changes the table's structure. Updating a student's age changes a stored value.

They are both database operations, but they solve different problems.

---

## 9. One Important MySQL Detail

These categories are a useful way to organize SQL, but they are not five completely independent systems.

Different database products can classify or implement certain commands differently. For example, `SELECT` is conventionally placed under DQL in learning materials, while some references treat it as part of a broader DML category.

MySQL also has specific behavior around statements that cause implicit commits. Some DDL statements can commit an active transaction, so I should not assume that every command can be undone with `ROLLBACK`.

For now, I will learn the common five-category model and focus on understanding what each command actually does.

---

## 10. What I Have Learned

After this lesson, I should be able to explain:

- **DDL:** Defines or changes database structure.
- **DML:** Adds, changes or removes stored records.
- **DQL:** Retrieves stored information.
- **DCL:** Manages database privileges.
- **TCL:** Controls transactions.

I do not need to memorize every SQL command today. I need to understand the purpose behind the categories so that the individual commands make sense as I learn them.

## 11. What Comes Next?

In Lesson 04, I will set up MySQL and understand the tools I need to practise SQL on my own computer.

Before moving forward, I want to remember this simple rule:

**First understand the job I want to perform. Then choose the SQL command that performs it.**