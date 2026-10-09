# Lesson 03 — SELECT: Reading Data

## Why Am I Learning This?

In the previous lesson, I learned how to create a table and put data inside it.

For example, I created a `students` table:

```text
id | name  | age | email
---|-------|-----|-------------------
1  | Vivek | 20  | vivek@example.com
2  | Rahul | 21  | rahul@example.com
3  | Aman  | 19  | aman@example.com
```

But storing data is only half of the job.

The real question is:

> How do I get the data back out of the database?

This is where `SELECT` comes in.

`SELECT` is one of the most important SQL commands because whenever my backend needs to **read data from a database**, I will be writing `SELECT` queries.

So in this lesson, I want to properly understand:

* What `SELECT` actually does
* How `SELECT` and `FROM` work together
* How to select all columns
* How to select specific columns
* How column order works
* How SQL can calculate values
* What aliases are
* What a result set is
* What happens when a `SELECT` query runs

I am not trying to memorize `SELECT` syntax.

I want to understand what I am asking the database to do.

---

# What Am I Going to Learn?

By the end of this lesson, I should understand:

1. What `SELECT` means
2. What `FROM` means
3. How to read all columns
4. How to read specific columns
5. How the order of selected columns affects the result
6. How expressions work inside `SELECT`
7. How aliases work using `AS`
8. What a result set is
9. Why `SELECT` does not modify my table
10. What happens internally when a `SELECT` query runs

---

# 1. The Problem: I Have Data, Now What?

Suppose I already created this table:

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    email VARCHAR(255)
);
```

And inserted some students:

```sql
INSERT INTO students (id, name, age, email)
VALUES
    (1, 'Vivek', 20, 'vivek@example.com'),
    (2, 'Rahul', 21, 'rahul@example.com'),
    (3, 'Aman', 19, 'aman@example.com');
```

The data is inside the database.

Now I want to see it.

I can ask:

```sql
SELECT *
FROM students;
```

The database gives me something like:

```text
+----+-------+-----+-------------------+
| id | name  | age | email             |
+----+-------+-----+-------------------+
|  1 | Vivek |  20 | vivek@example.com |
|  2 | Rahul |  21 | rahul@example.com |
|  3 | Aman  |  19 | aman@example.com |
+----+-------+-----+-------------------+
```

So the basic idea is:

```text
SELECT → What do I want to read?

FROM   → Where do I want to read it from?
```

This is the mental model I want to remember.

---

# 2. Understanding SELECT

The word `SELECT` basically means:

> Give me this data.

For example:

```sql
SELECT name
FROM students;
```

I am telling MySQL:

> Give me the `name` column from the `students` table.

The result:

```text
Vivek
Rahul
Aman
```

Notice something important.

I did not tell SQL which row to choose.

I only told it which column I want.

So:

```sql
SELECT name
FROM students;
```

means:

```text
From the students table
        ↓
Give me the name column
        ↓
For the rows available
```

Selecting particular rows will come later when I learn filtering.

---

# 3. Understanding FROM

`FROM` tells SQL where the data should come from.

```sql
SELECT name
FROM students;
```

Here:

```text
SELECT name
      ↓
what I want

FROM students
     ↓
where I want it from
```

So I can think of the basic structure as:

```sql
SELECT columns
FROM table;
```

This is one of the most important SQL patterns I will keep using.

---

# 4. Selecting Everything with *

If I want every column:

```sql
SELECT *
FROM students;
```

The `*` means:

> All columns.

So this:

```sql
SELECT *
FROM students;
```

is basically saying:

> Give me all columns from the students table.

If the table has:

```text
id
name
age
email
```

then all four columns will be returned.

---

# 5. SELECT * vs Specific Columns

I can also choose exactly which columns I want.

```sql
SELECT name, age
FROM students;
```

Result:

```text
+-------+-----+
| name  | age |
+-------+-----+
| Vivek |  20 |
| Rahul |  21 |
| Aman  |  19 |
+-------+-----+
```

The database still has:

```text
id
name
age
email
```

I am just asking the database to show me:

```text
name
age
```

This is an important distinction.

### The table has the data.

### SELECT decides what I want to see from that data.

---

# 6. Column Order Matters

Look at this:

```sql
SELECT name, age
FROM students;
```

The result starts with:

```text
name | age
```

But if I write:

```sql
SELECT age, name
FROM students;
```

the result becomes:

```text
age | name
```

The data has not changed.

Only the order of the columns in my result changed.

So:

```sql
SELECT name, age
FROM students;
```

and:

```sql
SELECT age, name
FROM students;
```

read the same table, but ask for the columns in a different order.

---

# 7. SELECT Does Not Change My Table

This is very important.

When I run:

```sql
SELECT name
FROM students;
```

I am only reading data.

I am not changing the table.

`SELECT` does not:

* add a row
* remove a row
* change a value
* change the table structure

It simply asks the database:

> Show me this data.

This is why `SELECT` belongs to the **read** side of SQL.

---

# 8. What Is a Result Set?

When I run:

```sql
SELECT name, age
FROM students;
```

My original table is not replaced.

Instead, MySQL produces a result.

That returned data is called a **result set**.

Think of it like this:

```text
students table
      |
      | SELECT name, age
      ↓
result set
```

The result set is basically the data produced by my query.

This becomes very important in backend development.

For example:

```text
Backend
   ↓
SQL query
   ↓
Database
   ↓
Result set
   ↓
Backend
   ↓
API response
```

So when my Node.js backend asks MySQL for users, the database returns a result set that my application can work with.

---

# 9. SELECT Can Also Calculate

`SELECT` is not limited to simply displaying existing columns.

It can also perform expressions.

For example:

```sql
SELECT age + 1
FROM students;
```

If the ages are:

```text
20
21
19
```

the result will be:

```text
21
22
20
```

The original table is still:

```text
20
21
19
```

I only calculated a new value for the result.

I can also do:

```sql
SELECT age * 2
FROM students;
```

or:

```sql
SELECT age + 5
FROM students;
```

So I can think of `SELECT` as:

> Give me existing data, calculated data, or both.

---

# 10. Using Columns Inside Expressions

I can combine multiple things inside a `SELECT`.

For example:

```sql
SELECT name, age + 1
FROM students;
```

This asks for:

```text
name
+
age increased by 1
```

The result could look like:

```text
+-------+----------+
| name  | age + 1  |
+-------+----------+
| Vivek |       21 |
| Rahul |       22 |
| Aman  |       20 |
+-------+----------+
```

The calculation is performed while creating the result.

It does not permanently change `age`.

---

# 11. The Problem With Calculated Column Names

Look at this:

```sql
SELECT name, age + 1
FROM students;
```

The database may show the second column as:

```text
age + 1
```

That's not a very useful name.

I can give the result column a better name.

This is where **aliases** come in.

---

# 12. Column Aliases

I can use `AS` to give a column a temporary name in the result.

```sql
SELECT name, age + 1 AS age_next_year
FROM students;
```

Now the result can look like:

```text
+-------+---------------+
| name  | age_next_year |
+-------+---------------+
| Vivek |            21 |
| Rahul |            22 |
| Aman  |            20 |
+-------+---------------+
```

The important thing is:

```sql
age + 1 AS age_next_year
```

means:

```text
calculate age + 1
        ↓
call that result age_next_year
```

---

# 13. Aliases Do Not Rename the Actual Column

This is another important point.

Suppose I write:

```sql
SELECT name AS student_name
FROM students;
```

I have **not renamed the `name` column**.

The actual table still contains:

```text
name
```

I only changed the name displayed in this particular result.

Think:

```text
Actual table
    ↓
name

SELECT result
    ↓
student_name
```

The alias belongs to the result of the query.

---

# 14. Aliases Can Make Results Easier to Understand

For example:

```sql
SELECT
    name AS student_name,
    age AS student_age,
    email AS student_email
FROM students;
```

This can make the result easier to understand:

```text
student_name | student_age | student_email
-------------|-------------|-------------------
Vivek        | 20          | vivek@example.com
Rahul        | 21          | rahul@example.com
Aman         | 19          | aman@example.com
```

Aliases are especially useful when:

* calculating values
* joining multiple tables
* making result columns easier to understand
* preparing data for an application

I will use aliases much more as SQL becomes more advanced.

---

# 15. SELECT Can Work Without a Table

Something interesting about SQL:

I can even use `SELECT` without `FROM`.

For example:

```sql
SELECT 10 + 5;
```

Result:

```text
15
```

Or:

```sql
SELECT 'Hello SQL';
```

Result:

```text
Hello SQL
```

Why does this work?

Because `SELECT` can evaluate an expression.

There is no table involved here.

I am simply asking MySQL:

> Evaluate this expression and give me the result.

This is not how I will normally read application data, but it helps me understand what `SELECT` actually does.

---

# 16. Anatomy of a Basic SELECT Query

Let's break this down:

```sql
SELECT name, age
FROM students;
```

### `SELECT`

Tells SQL what I want in the result.

### `name, age`

The columns I want.

### `FROM`

Tells SQL where the data comes from.

### `students`

The table I am reading.

### `;`

Marks the end of the SQL statement.

So the basic structure is:

```text
SELECT
  ↓
What data do I want?

FROM
  ↓
Where is that data?

table
  ↓
Which table?
```

---

# 17. What Actually Happens When I Run SELECT?

When I run:

```sql
SELECT name, age
FROM students;
```

I can mentally imagine this:

```text
My SQL query
     ↓
MySQL understands the query
     ↓
MySQL finds the students table
     ↓
MySQL gets the requested columns
     ↓
MySQL creates a result set
     ↓
I see the result
```

The database is not just printing the table.

It is executing my request and producing a result based on that request.

---

# 18. Written SQL vs What I Mean

When I write:

```sql
SELECT name, age
FROM students;
```

I am not telling MySQL:

> First do this, then do this.

I am describing **what result I want**.

This is one reason SQL is called a **declarative language**.

I describe the result I want, and the database figures out how to get it.

For now, I don't need to understand the optimizer deeply.

I just need to remember:

> I tell SQL what data I want, not exactly how the database must fetch it.

---

# 19. SELECT Compared With MongoDB

Since I already know MongoDB, I can connect the ideas.

In MongoDB, I might write:

```javascript
db.students.find()
```

to get documents.

In SQL:

```sql
SELECT *
FROM students;
```

Both are asking the database for data.

For specific fields, MongoDB might look like:

```javascript
db.students.find({}, { name: 1, age: 1 })
```

SQL:

```sql
SELECT name, age
FROM students;
```

The syntax is different, but the basic idea is familiar:

```text
MongoDB
collection → find → documents/fields

SQL
table → SELECT → rows/columns
```

I should use this comparison only to build intuition.

SQL is not MongoDB with different syntax.

The relational model underneath is different.

---

# 20. A Simple Mental Model

Whenever I see:

```sql
SELECT name, email
FROM students;
```

I should immediately think:

```text
students table
      ↓
Which columns?
      ↓
name + email
      ↓
Return the matching result
```

Or simply:

```text
SELECT → What?

FROM   → Where?
```

This is the most important mental model from this lesson.

---

# 21. My First SELECT Workflow

When I want to explore a table, I can start with:

### Step 1 — See everything

```sql
SELECT *
FROM students;
```

### Step 2 — Pick the columns I actually need

```sql
SELECT name, email
FROM students;
```

### Step 3 — Calculate something if needed

```sql
SELECT name, age + 1
FROM students;
```

### Step 4 — Give the result a useful name

```sql
SELECT name, age + 1 AS age_next_year
FROM students;
```

This is a simple workflow I can repeat while learning.

---

# 22. Things I Should Not Learn Yet

There are still things I haven't learned.

For example:

```sql
WHERE
ORDER BY
LIMIT
```

These will help me control **which rows** I get and **how they are arranged**.

But I don't want to mix everything together yet.

For this lesson, I want to be completely comfortable with:

```sql
SELECT
FROM
*
columns
expressions
AS
```

Once that makes sense, filtering and sorting will be much easier.

---

# 23. Practice

Before moving on, I should be able to write these myself.

### Practice 1

Display all students.

```sql
SELECT *
FROM students;
```

### Practice 2

Display only student names.

```sql
SELECT name
FROM students;
```

### Practice 3

Display student names and ages.

```sql
SELECT name, age
FROM students;
```

### Practice 4

Display names and their ages next year.

```sql
SELECT name, age + 1 AS age_next_year
FROM students;
```

### Practice 5

Display name and email using aliases.

```sql
SELECT
    name AS student_name,
    email AS student_email
FROM students;
```

But I should try writing these myself in `playground.sql` before looking at the answers.

---

# 24. Common Mistakes

### Forgetting FROM

```sql
SELECT name;
```

This is not how I normally read the `students` table.

I need:

```sql
SELECT name
FROM students;
```

---

### Using the wrong table name

```sql
SELECT name
FROM student;
```

If the actual table is called `students`, MySQL won't find `student`.

Table names matter.

---

### Selecting a column that does not exist

```sql
SELECT username
FROM students;
```

If `students` has no `username` column, MySQL will give an error.

---

### Thinking SELECT changes data

```sql
SELECT age + 1
FROM students;
```

This does not permanently increase everyone's age.

It only calculates a value for the result.

---

### Thinking AS renames the actual column

```sql
SELECT name AS student_name
FROM students;
```

This does not rename `name` in the table.

It only changes the name shown in the result.

---

# 25. What I Learned

In this lesson, I learned that:

* `SELECT` is used to read data.
* `FROM` tells SQL where the data comes from.
* `*` means all columns.
* I can select only the columns I need.
* The order of columns in `SELECT` affects the result.
* `SELECT` can perform calculations.
* `AS` creates an alias for a result column.
* An alias does not rename the actual table column.
* A query produces a result set.
* `SELECT` reads data without modifying the table.
* SQL is declarative because I describe the result I want.
* I can think of a basic query as:

```text
SELECT → What do I want?

FROM → Where do I want it from?
```

---

# Lesson Progression

```text
L01 → Understanding SQL & Relational Databases
          ↓
L02 → Tables, Rows & Columns
          ↓
L03 → SELECT: Reading Data
          ↓
L04 → Filtering & Sorting
```

I have now gone from:

```text
Understanding databases
        ↓
Creating tables
        ↓
Adding data
        ↓
Reading data
```

The next question is:

> What if I don't want every row?

That's where filtering comes in.

---

# Next Lesson

## Lesson 04 — Filtering & Sorting

Next, I will learn how to control **which rows** I get back and **how they are arranged**.

I will learn:

* `WHERE`
* Comparison operators
* `AND` / `OR`
* `IN`
* `BETWEEN`
* `LIKE`
* `ORDER BY`
* `ASC` / `DESC`
* `LIMIT`

For now, I want to be completely comfortable with:

```sql
SELECT
FROM
*
columns
AS
```

before moving forward.
