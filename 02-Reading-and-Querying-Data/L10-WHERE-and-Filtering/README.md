# L10 - WHERE and Filtering

## Why Am I Learning This?

In the previous lesson, I learned how to retrieve data from a table using the `SELECT` statement.

But imagine I'm building a School Management System.

The database contains thousands of student records, and a student logs into the portal to view their own profile.

Should my backend retrieve every student's record and then search through all of them to find the logged-in student?

Of course not!

That would be unnecessary, especially when the database contains thousands or even millions of records.

I need a way to tell the database:

"Find the student whose ID is 105 and return only that student's information."

This is where the `WHERE` clause comes in.

The `WHERE` clause allows me to filter records based on a specified condition. Instead of retrieving every row, I can retrieve only the rows that match my requirement.

Since I've already studied MongoDB, I can relate this to filtering documents using `find()`.

For example, in MongoDB, I might write:

```javascript
db.students.find({ student_id: 105 });
```

In MySQL, the equivalent idea is:

```sql
SELECT *
FROM students
WHERE student_id = 105;
```

Both queries retrieve matching records, but they use different query syntax.

In this lesson, I'll understand how SQL filtering works and how I can use it in real backend applications.

## What Am I Going to Study?

I'll learn these concepts in the following order:

1. What Is the WHERE Clause?
2. Understanding the Basic Syntax
3. Filtering Records Using WHERE
4. Filtering Text Values
5. Filtering Numeric Values
6. Understanding How WHERE Works
7. SQL WHERE vs MongoDB find()
8. Practical Examples Using the Students Table

## 1. What Is the WHERE Clause?

The `WHERE` clause is used to specify a condition that records must satisfy.

When used with `SELECT`, it helps me retrieve only the rows that match my condition.

Think about an online shopping application.

Suppose a customer wants to find a particular product using its product ID.

The application doesn't need to retrieve every product from the database. It only needs the product matching that ID.

The same idea applies to my School Management System.

Suppose my `students` table contains:

| student_id | name | age | course |
|---|---|---|---|
| 101 | John | 20 | CSE |
| 102 | Roman | 21 | IT |
| 103 | Seth | 19 | CSE |
| 104 | Randy | 22 | ECE |
| 105 | Brock | 20 | Mechanical |

Now, suppose I only want to retrieve students enrolled in CSE.

I can write:

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

**Result:**

| student_id | name | age | course |
|---|---|---|---|
| 101 | John | 20 | CSE |
| 103 | Seth | 19 | CSE |

Notice that MySQL returned only John and Seth because their course is CSE.

The other records weren't included because they didn't match the condition.

That's the basic idea behind filtering.

## 2. Understanding the Basic Syntax

The basic syntax of a SELECT query with WHERE is:

```sql
SELECT column_name
FROM table_name
WHERE condition;
```

Let's understand each part:

- `SELECT`: Specifies which columns I want to retrieve.
- `FROM`: Specifies the table from which I want to retrieve data.
- `WHERE`: Introduces the filtering condition.
- `condition`: Specifies which records should be included in the result.

For example:

```sql
SELECT name, course
FROM students
WHERE course = 'CSE';
```

Here, I'm telling MySQL:

1. Retrieve the `name` and `course` columns.
2. Look inside the `students` table.
3. Include only records where the course is CSE.

An important thing to understand is:

- `SELECT` decides which columns appear in the result.
- `WHERE` decides which rows appear in the result.

This distinction is important because both clauses perform different jobs.

## 3. Filtering Records Using WHERE

Let's understand filtering through some practical situations.

### Example 1: Finding Students From a Particular Course

Imagine the college administration wants to display all students enrolled in the IT department.

I can retrieve those records using:

```sql
SELECT *
FROM students
WHERE course = 'IT';
```

**Result:**

| student_id | name | age | course |
|---|---|---|---|
| 102 | Roman | 21 | IT |

Only Roman's record matches the condition.

### Example 2: Finding a Particular Student

Suppose a student logs into the college portal, and the backend needs to retrieve their profile using their student ID.

I can write:

```sql
SELECT *
FROM students
WHERE student_id = 105;
```

**Result:**

| student_id | name | age | course |
|---|---|---|---|
| 105 | Brock | 20 | Mechanical |

This is a common operation in backend applications.

For example, when a frontend requests:

```text
GET /students/105
```

The backend can use the student ID from the URL to retrieve the corresponding record from MySQL.

### Example 3: Retrieving Only Required Information

Suppose the college wants to display only the names of students enrolled in CSE.

I don't need their complete records.

Instead, I can write:

```sql
SELECT name
FROM students
WHERE course = 'CSE';
```

**Result:**

| name |
|---|
| John |
| Seth |

Here:

- `SELECT name` decides which column to display.
- `WHERE course = 'CSE'` decides which records to retrieve.

I'm selecting only the information the application needs.

## 4. Filtering Text Values

When filtering records using text values, I generally place the value inside single quotation marks.

For example:

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

Here, `'CSE'` is a text value stored in the `course` column.

Similarly, I can search for a particular student's name:

```sql
SELECT *
FROM students
WHERE name = 'Roman';
```

**Result:**

| student_id | name | age | course |
|---|---|---|---|
| 102 | Roman | 21 | IT |

### Why Do I Use Quotation Marks?

SQL needs to distinguish between column names and literal text values.

Consider:

```sql
WHERE course = 'CSE'
```

- `course` is a column name.
- `'CSE'` is a text value I'm searching for.

For text values, single quotes are the standard SQL convention.

### What About MongoDB?

In MongoDB, I would write:

```javascript
db.students.find({ course: "CSE" });
```

Notice the difference:

- MongoDB uses a JavaScript object-like filter.
- MySQL uses a condition inside the `WHERE` clause.
- Both are checking whether the course field contains the value `CSE`.

One important difference is that MongoDB uses double quotes in JSON-style examples, while SQL commonly uses single quotes for text values.

## 5. Filtering Numeric Values

Not every condition involves text.

Suppose the college wants to find students who are exactly 20 years old.

I can write:

```sql
SELECT *
FROM students
WHERE age = 20;
```

**Result:**

| student_id | name | age | course |
|---|---|---|---|
| 101 | John | 20 | CSE |
| 105 | Brock | 20 | Mechanical |

Notice that I didn't put quotation marks around `20`.

That's because `age` is a numeric column.

Compare the syntax:

```sql
-- Filtering using a text value
SELECT *
FROM students
WHERE course = 'CSE';

-- Filtering using a numeric value
SELECT *
FROM students
WHERE age = 20;
```

### What About MongoDB?

The equivalent MongoDB query is:

```javascript
db.students.find({ age: 20 });
```

Both databases compare the stored numeric value with the number I'm providing.

The important thing is to understand the data type of the column or field I'm filtering.

## 6. Understanding How WHERE Works

Let's understand what happens when MySQL executes a query containing a WHERE condition.

Consider:

```sql
SELECT name, course
FROM students
WHERE course = 'CSE';
```

Conceptually, MySQL:

1. Identifies the `students` table.
2. Checks which rows satisfy the condition.
3. Keeps the matching rows.
4. Returns the requested columns from those rows.

I can visualize it like this:

```text
             students table
                   |
                   v
          WHERE course = 'CSE'
                   |
          +--------+--------+
          |                 |
       Matches           Doesn't
          |              match
          v                 |
     John - CSE             |
     Seth - CSE             |
          |                 |
          v                 |
       SELECT name, course
          |
          v
       Final Result
```

The important thing is that filtering doesn't delete or modify records.

It only controls which records are included in the query result.

Also, this is a conceptual explanation of the query. MySQL's actual query optimizer may choose a different execution strategy depending on indexes and other factors.

## 7. SQL WHERE vs MongoDB find()

Since I've already studied MongoDB, comparing both approaches will help me understand SQL filtering more easily.

Let's look at some equivalent queries.

| Requirement | MySQL | MongoDB |
|---|---|---|
| Find all CSE students | `WHERE course = 'CSE'` | `{ course: "CSE" }` |
| Find student with ID 105 | `WHERE student_id = 105` | `{ student_id: 105 }` |
| Find students aged 20 | `WHERE age = 20` | `{ age: 20 }` |

For example, suppose I want to retrieve all CSE students.

**MySQL:**

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

**MongoDB:**

```javascript
db.students.find({ course: "CSE" });
```

The main difference is how I express the filtering condition.

In MySQL, I write conditions using SQL syntax.

In MongoDB, I pass a filter document to methods like `find()`.

The underlying idea is similar: retrieve only the records that match my requirement.

I'll explore more advanced filtering conditions in the upcoming lessons.

## 8. Practical Understanding: School Management System

Now let's connect everything to the database I'm building throughout this course.

Imagine my School Management System has a `students` table.

The college administration might have different requirements:

**Situation 1: Find all students enrolled in CSE.**

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

**Situation 2: Find the student whose ID is 104.**

```sql
SELECT *
FROM students
WHERE student_id = 104;
```

**Situation 3: Display the names of students who are 20 years old.**

```sql
SELECT name
FROM students
WHERE age = 20;
```

**Situation 4: Find all students enrolled in Mechanical.**

```sql
SELECT *
FROM students
WHERE course = 'Mechanical';
```

**Situation 5: Find a student named Roman.**

```sql
SELECT *
FROM students
WHERE name = 'Roman';
```

Each query retrieves only the records that match the specified condition.

This is how I can retrieve meaningful information from a database instead of blindly fetching every record.

## Quick Revision

| Concept | Meaning |
|---|---|
| `WHERE` | Filters records based on a condition |
| Condition | A requirement that a record must satisfy |
| `WHERE course = 'CSE'` | Retrieves records where the course is CSE |
| `WHERE age = 20` | Retrieves records where the age is 20 |
| `WHERE student_id = 105` | Retrieves the record with student ID 105 |
| Text values | Generally written inside single quotes |
| Numeric values | Written without quotation marks |
| MongoDB `find()` | Retrieves documents matching a filter |

### Important Points to Remember

1. `WHERE` is used to filter rows in a table.
2. `SELECT` determines which columns appear in the result.
3. `WHERE` determines which rows are included in the result.
4. Text values are generally enclosed in single quotes.
5. Numeric values don't require quotation marks.
6. Filtering data doesn't modify the original table.
7. If no records match the condition, MySQL returns an empty result set.
8. MongoDB's `find()` and SQL's `WHERE` provide similar filtering capabilities, but their syntax is different.

## What Should I Be Able to Explain After This Lesson?

Before moving ahead, I should be able to explain:

- What is the purpose of the `WHERE` clause?
- Why do I need filtering in SQL?
- What is the basic syntax of WHERE?
- How can I retrieve records matching a particular text value?
- How can I filter records using numeric values?
- Why do text values use quotation marks?
- What is the difference between `SELECT` and `WHERE`?
- How does SQL filtering compare with MongoDB's `find()`?
- Does filtering modify the original table?
- What happens when no records match the condition?

## What's Next?

So far, I've learned how to filter records using a single condition.

But what if I want to retrieve students who are enrolled in CSE **and** are 20 years old?

Or students who belong to either CSE **or** IT?

A single condition isn't always enough. Sometimes I need to combine multiple conditions to retrieve exactly the records I want.

That's what I'll learn in the next lesson:

**L11 - Logical Operators**

I'll understand how `AND`, `OR`, and `NOT` help me combine and control multiple filtering conditions.