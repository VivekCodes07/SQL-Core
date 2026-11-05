# L09 - SELECT (Reading Data)

## Why Am I Learning This?

So far, I've learned how to create databases, work with tables, understand data types, and perform basic table operations.

But think about a real-world application like a School Management System.

Suppose I have a `students` table containing hundreds of student records. If I want to see the names of all students, do I really need to open the database and look through every row manually?

Of course not!

I need a way to **ask the database for the information I want**.

This is where SQL queries come in.

The `SELECT` statement allows me to retrieve data stored inside database tables. It is one of the most frequently used SQL statements, especially when building backend applications.

Whenever a user opens their profile, checks student details, or views a list of students, the backend retrieves that information using SQL queries.

In this lesson, I'll understand how to read data from a table using `SELECT`.

## What Am I Going to Study?

I'll learn these concepts in the following order:

1. What is an SQL Query?
2. Understanding the SELECT Statement
3. Retrieving All Columns Using `SELECT *`
4. Retrieving Specific Columns
5. Selecting Multiple Columns
6. Understanding Column Aliases Using `AS`
7. Understanding Query Results

## 1. What Is an SQL Query?

An SQL query is simply a request that I send to a database to perform an operation.

For example, I might want to:

- Retrieve all students.
- Create a new table.
- Insert a student's record.
- Update existing information.
- Delete a record.

Each of these operations can be performed using SQL statements.

For this lesson, I'll focus on retrieving information.

Think of it like asking a librarian:

"Show me all the students registered in this school."

Instead of manually searching through records, I write a query and let the database retrieve the information.

## 2. Understanding the SELECT Statement

The `SELECT` statement is used to retrieve data from one or more database tables.

Its basic syntax is:

```sql
SELECT column_name
FROM table_name;
```

Let's understand what each part means:

- `SELECT`: Tells MySQL what information I want to retrieve.
- `column_name`: Specifies which column's data I want.
- `FROM`: Tells MySQL which table contains that data.
- `table_name`: The table from which I want to retrieve information.

For example, suppose I have a table called `students`:

| student_id | name | age | course |
|---|---|---|---|
| 1 | John | 20 | CSE |
| 2 | Roman | 21 | IT |
| 3 | Seth | 19 | CSE |
| 4 | Randy | 22 | ECE |

If I want to retrieve the names of students, I can write:

```sql
SELECT name
FROM students;
```

The result will be:

| name |
|---|
| John |
| Roman |
| Seth |
| Randy |

Notice that MySQL returned only the `name` column because that's what I requested.

The original table hasn't changed. I'm only reading its data.

## 3. Retrieving All Columns Using SELECT *

What if I want to see all the information stored in the `students` table?

Writing every column name individually would be unnecessary.

SQL provides a shortcut: the asterisk (`*`).

```sql
SELECT *
FROM students;
```

Here, `*` means all columns.

The result will contain:

| student_id | name | age | course |
|---|---|---|---|
| 1 | John | 20 | CSE |
| 2 | Roman | 21 | IT |
| 3 | Seth | 19 | CSE |
| 4 | Randy | 22 | ECE |

This query retrieves every column from the `students` table.

### Should I Always Use SELECT *?

Not necessarily.

Although `SELECT *` is convenient while learning or exploring a table, specifying the required columns is generally better in backend applications.

For example, if an application only needs student names, retrieving every column would bring unnecessary data.

Instead of:

```sql
SELECT *
FROM students;
```

I should write:

```sql
SELECT name
FROM students;
```

This makes my query more intentional and avoids retrieving information that the application doesn't need.

## 4. Retrieving Specific Columns

I don't always need every column from a table.

Suppose I want to display only the student's name and course.

I can specify both column names after `SELECT`, separated by commas.

```sql
SELECT name, course
FROM students;
```

The result will be:

| name | course |
|---|---|
| John | CSE |
| Roman | IT |
| Seth | CSE |
| Randy | ECE |

Here, MySQL retrieves only the requested columns.

A few things to remember:

- Column names must be separated by commas.
- The columns are returned in the same order in which I specify them.
- The original table structure and stored data remain unchanged.

For example:

```sql
SELECT course, name
FROM students;
```

The result will now show `course` before `name`.

## 5. Selecting Multiple Columns

I can retrieve as many columns as I need by separating their names with commas.

For example:

```sql
SELECT student_id, name, age, course
FROM students;
```

This retrieves all four columns, but unlike `SELECT *`, I have explicitly mentioned what I want.

Let's understand the difference:

| Query | What it retrieves |
|---|---|
| `SELECT * FROM students;` | Every column |
| `SELECT name FROM students;` | Only the name column |
| `SELECT name, age FROM students;` | Name and age |
| `SELECT course, name FROM students;` | Course followed by name |

The important thing is that `SELECT` controls which columns appear in the result.

## 6. Giving Column Names Using AS (Column Aliases)

Sometimes, the original column names in a database might not be meaningful or user-friendly when displaying query results.

For example, my `students` table contains a column named `name`.

But suppose I'm building a School Management System and want the result to display that column as `student_name`.

Do I need to rename the actual column in my database?

No!

SQL provides something called **Column Aliases**.

A column alias allows me to give a temporary name to a column in the result returned by a query.

### Basic Syntax

```sql
SELECT column_name AS alias_name
FROM table_name;
```

Let's understand this with an example:

```sql
SELECT name AS student_name
FROM students;
```

The result will look like this:

| student_name |
|---|
| John |
| Roman |
| Seth |
| Randy |

Notice something important:

- The actual column name in the table is still `name`.
- The query result displays it as `student_name`.
- The database structure hasn't changed.

The alias only changes the column heading in the result. It doesn't permanently rename the column.

### Using Aliases with Multiple Columns

I can also assign aliases to multiple columns in the same query.

```sql
SELECT
    student_id AS id,
    name AS student_name,
    course AS enrolled_course
FROM students;
```

The result will look like this:

| id | student_name | enrolled_course |
|---|---|---|
| 1 | John | CSE |
| 2 | Roman | IT |
| 3 | Seth | CSE |
| 4 | Randy | ECE |

Here, I've given meaningful names to all three columns without changing the original table.

### Is AS Mandatory?

No. In MySQL, the `AS` keyword is optional when assigning column aliases.

Both queries work:

```sql
SELECT name AS student_name
FROM students;
```

```sql
SELECT name student_name
FROM students;
```

However, I prefer using `AS` because it makes my query easier to read and understand, especially when working with multiple columns.

### Why Are Aliases Useful?

Imagine that my backend retrieves student information and displays it somewhere in an application.

Instead of returning a heading like `name`, I might want a more descriptive heading like `student_name`.

Aliases help make query results easier to understand and work with.

**Important:** Column aliases are temporary. They don't change the actual column names stored in the database.

I'll explore column aliases in greater detail in **L15 - Column Aliases**.

## 7. Understanding Query Results

One important thing I need to understand is that retrieving data does not mean modifying data.

Consider this query:

```sql
SELECT name, age
FROM students;
```

MySQL reads the requested information and returns a result set.

A **result set** is simply the collection of rows and columns returned by a query.

For example:

| name | age |
|---|---|
| John | 20 |
| Roman | 21 |
| Seth | 19 |
| Randy | 22 |

The original `students` table remains exactly the same.

This distinction is important because SQL has different statements for different purposes:

- `SELECT` reads data.
- `INSERT` adds data.
- `UPDATE` modifies data.
- `DELETE` removes data.

I'll study data modification in detail later in this course.

## 8. Practical Understanding: School Management System

Now let's connect everything to the database I'm building throughout this course.

Imagine that my School Management System has a `students` table.

I might need different information for different situations:

**Situation 1: I want to see every student record.**

```sql
SELECT *
FROM students;
```

**Situation 2: I want to display only student names.**

```sql
SELECT name
FROM students;
```

**Situation 3: I want to display student names and their ages.**

```sql
SELECT name, age
FROM students;
```

**Situation 4: I want to see student IDs, names, and courses.**

```sql
SELECT student_id, name, course
FROM students;
```

**Situation 5: I want to display a more meaningful column heading.**

```sql
SELECT name AS student_name
FROM students;
```

Notice how the same table can provide different results depending on what information I request.

This is the basic idea behind reading data using SQL.

## Quick Revision

| Concept | Meaning |
|---|---|
| SQL Query | A request sent to the database |
| `SELECT` | Retrieves data from a table |
| `FROM` | Specifies the source table |
| `*` | Represents all columns |
| `SELECT name` | Retrieves only the name column |
| `SELECT name, age` | Retrieves multiple columns |
| `AS` | Gives a temporary name to a column |
| Column Alias | An alternative heading in the query result |
| Result Set | Data returned by a query |

### Important Points to Remember

1. `SELECT` is used to read data, not modify it.
2. `SELECT *` retrieves all columns from a table.
3. I can retrieve specific columns by mentioning their names.
4. Multiple column names must be separated by commas.
5. The order of columns in the result depends on the order in my query.
6. `AS` allows me to give temporary names to columns in the result.
7. Column aliases don't permanently rename database columns.
8. Reading data does not change the original table.

## What Should I Be Able to Explain After This Lesson?

Before moving ahead, I should be able to explain:

- What is an SQL query?
- What does the `SELECT` statement do?
- What is the purpose of the `FROM` keyword?
- What does `SELECT *` mean?
- How can I retrieve only specific columns?
- How can I retrieve multiple columns?
- What is a column alias?
- What is the purpose of the `AS` keyword?
- Does an alias change the actual column name?
- What is a result set?
- Does a SELECT query modify the original table?
- Why is selecting only the required columns useful in backend development?

## What's Next?

Now I know how to retrieve data from a table.

But there's a problem.

Suppose my `students` table contains 1,000 records, and I only want to see students whose course is CSE.

Retrieving all 1,000 records is unnecessary.

I need a way to specify a condition and retrieve only the records that match it.

That's exactly what I'll learn in the next lesson:

**L10 - WHERE and Filtering**

I'll understand how to retrieve only the records I actually need.