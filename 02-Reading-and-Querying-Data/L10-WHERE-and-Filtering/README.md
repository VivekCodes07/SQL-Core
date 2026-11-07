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

The `WHERE` clause allows me to filter records based on specified conditions. Instead of retrieving every row, I can retrieve only the rows that match my requirement.

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

However, filtering isn't limited to checking whether two values are equal.

What if I want to search for names starting with a particular letter, find records with missing values, or match a column against several possible values?

That's why I'll explore some additional filtering techniques in this lesson.

## What Am I Going to Study?

I'll learn these concepts in the following order:

1. What Is the WHERE Clause?
2. Understanding the Basic Syntax
3. Filtering Records Using WHERE
4. Filtering Text Values
5. Filtering Numeric Values
6. Filtering NULL Values (`IS NULL`, `IS NOT NULL`)
7. Pattern Matching Using `LIKE` and `NOT LIKE`
8. Filtering Multiple Values Using `IN` and `NOT IN`
9. Understanding How WHERE Works
10. SQL WHERE vs MongoDB find()
11. Practical Examples Using the Students Table

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

## 6. Filtering NULL Values

### Why Do I Need to Check for NULL?

Imagine a student registers on the college portal but hasn't provided their phone number yet.

The student record already exists, but the phone number hasn't been entered.

How should the database represent this situation?

This is where `NULL` becomes important.

In SQL, `NULL` represents a missing or unknown value.

For example, imagine my `students` table has an additional `phone` column:

| student_id | name | phone |
|---|---|---|
| 101 | John | 9876543210 |
| 102 | Roman | NULL |
| 103 | Seth | 9123456780 |
| 104 | Randy | NULL |

Roman and Randy haven't provided their phone numbers.

I might initially think that I can find them using:

```sql
SELECT *
FROM students
WHERE phone = NULL;
```

But this is incorrect!

### Why Can't I Use `= NULL`?

`NULL` is not an ordinary value.

It represents something unknown or missing. Therefore, comparing a value with `NULL` using `=` or `!=` doesn't work as a normal comparison.

Instead, SQL provides two special conditions:

- `IS NULL`
- `IS NOT NULL`

### IS NULL

`IS NULL` retrieves records where a particular column contains a NULL value.

For example:

```sql
SELECT *
FROM students
WHERE phone IS NULL;
```

**Expected Result:**

| student_id | name | phone |
|---|---|---|
| 102 | Roman | NULL |
| 104 | Randy | NULL |

This helps me find students who haven't provided their phone numbers.

### IS NOT NULL

Sometimes I want to find records where a value is already available.

That's where `IS NOT NULL` comes in.

```sql
SELECT *
FROM students
WHERE phone IS NOT NULL;
```

**Expected Result:**

| student_id | name | phone |
|---|---|---|
| 101 | John | 9876543210 |
| 103 | Seth | 9123456780 |

This returns students whose phone number is present.

### NULL vs Empty String

This is an important distinction.

`NULL` and an empty string (`''`) are not the same thing.

| Value | Meaning |
|---|---|
| `NULL` | No value is available or known |
| `''` | A value exists, but it contains zero characters |
| `' '` | A string containing a space |
| `'9876543210'` | An actual text value |

For example, if I store an empty string in the phone column, `IS NULL` won't identify that record.

This distinction is important when validating user input in backend applications.

### What About MongoDB?

In MongoDB, I can check for null-like values using:

```javascript
db.students.find({ phone: null });
```

However, MongoDB's behavior is slightly different: this query can match documents where `phone` is explicitly `null` or where the field is missing entirely.

To find documents where the field exists and is explicitly null:

```javascript
db.students.find({
  phone: { $exists: true, $eq: null }
});
```

The important difference is that SQL tables have defined columns, whereas MongoDB documents can have fields that are missing entirely.

## 7. Pattern Matching Using LIKE

### Why Do I Need LIKE?

Suppose a student searches for another student, but they only remember that the student's name starts with the letter `R`.

They don't remember the complete name.

If I use equality:

```sql
SELECT *
FROM students
WHERE name = 'R';
```

This searches for a name that is exactly `R`.

But I want to find names that start with `R`, such as Roman or Randy.

That's where the `LIKE` operator comes in.

### What Is LIKE?

`LIKE` is used to search for text values that match a particular pattern.

Unlike `=`, which checks for an exact match, `LIKE` allows me to search using wildcard characters.

MySQL provides two commonly used wildcard characters:

| Wildcard | Meaning |
|---|---|
| `%` | Matches zero or more characters |
| `_` | Matches exactly one character |

Let's understand them with examples.

### Example 1: Names Starting With R

```sql
SELECT *
FROM students
WHERE name LIKE 'R%';
```

Here:

- `R` means the name must start with R.
- `%` means any number of characters can follow it.

**Expected Result:**

| student_id | name |
|---|---|
| 102 | Roman |
| 104 | Randy |

### Example 2: Names Ending With N

```sql
SELECT *
FROM students
WHERE name LIKE '%n';
```

Here, `%` allows any characters before the letter `n`.

**Expected Result:**

| student_id | name |
|---|---|
| 101 | John |

### Example 3: Names Containing A

```sql
SELECT *
FROM students
WHERE name LIKE '%a%';
```

Here, the letter `a` can appear anywhere in the name.

**Expected Result:**

| student_id | name |
|---|---|
| 104 | Randy |

### Example 4: Using the Underscore (`_`) Wildcard

Suppose I want to find names where the second character is `o`.

```sql
SELECT *
FROM students
WHERE name LIKE '_o%';
```

Let's understand the pattern:

- First `_` represents exactly one character.
- `o` means the second character must be `o`.
- `%` allows any number of characters after it.

**Expected Result:**

| student_id | name |
|---|---|
| 101 | John |
| 102 | Roman |

### NOT LIKE

Sometimes I want to exclude names matching a particular pattern.

That's where `NOT LIKE` helps.

For example, find names that don't start with `R`:

```sql
SELECT *
FROM students
WHERE name NOT LIKE 'R%';
```

This returns John, Seth, and Brock.

### What About MongoDB?

MongoDB supports pattern matching through regular expressions.

For example, to find names starting with R:

```javascript
db.students.find({
  name: /^R/
});
```

The idea is similar, but MongoDB uses regular expressions while SQL uses the `LIKE` operator and its wildcard characters.

**Important:** MySQL's `LIKE` matching can be case-insensitive depending on the column's collation. The exact behavior depends on the column configuration.

## 8. Filtering Multiple Values Using IN

### Why Do I Need IN?

Imagine the college administration wants to retrieve students enrolled in either CSE, IT, or ECE.

I could write:

```sql
SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT'
OR course = 'ECE';
```

This works, but imagine checking against 10 or 20 different courses.

The query would become unnecessarily long.

MySQL provides the `IN` operator to make this easier.

### What Is IN?

`IN` checks whether a value matches any value inside a specified list.

Instead of writing multiple equality conditions connected by `OR`, I can provide a list of acceptable values.

### SQL Example

```sql
SELECT *
FROM students
WHERE course IN ('CSE', 'IT', 'ECE');
```

**Expected Result:**

| student_id | name | course |
|---|---|---|
| 101 | John | CSE |
| 102 | Roman | IT |
| 103 | Seth | CSE |
| 104 | Randy | ECE |

This query returns students whose course matches at least one value in the list.

### Understanding IN vs OR

Both queries perform the same filtering operation:

**Using OR:**

```sql
SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT'
OR course = 'ECE';
```

**Using IN:**

```sql
SELECT *
FROM students
WHERE course IN ('CSE', 'IT', 'ECE');
```

The second query is shorter and easier to maintain when checking multiple possible values.

### NOT IN

What if I want to find students who are not enrolled in CSE or IT?

I can use `NOT IN`.

```sql
SELECT *
FROM students
WHERE course NOT IN ('CSE', 'IT');
```

**Expected Result:**

| student_id | name | course |
|---|---|---|
| 104 | Randy | ECE |
| 105 | Brock | Mechanical |

This returns records whose course doesn't match any value in the specified list.

One important thing: avoid including `NULL` inside a `NOT IN` list unless you specifically understand SQL's NULL behavior. It can cause the condition to produce unexpected results.

### What About MongoDB?

MongoDB provides `$in` and `$nin` operators for similar filtering.

**SQL:**

```sql
SELECT *
FROM students
WHERE course IN ('CSE', 'IT');
```

**MongoDB:**

```javascript
db.students.find({
  course: { $in: ["CSE", "IT"] }
});
```

Similarly, MongoDB's `$nin` can be used to exclude matching values.

```javascript
db.students.find({
  course: { $nin: ["CSE", "IT"] }
});
```

The concept is similar, but the syntax is different.

## 9. Understanding How WHERE Works

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
          |               match
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

## 10. SQL WHERE vs MongoDB find()

Since I've already studied MongoDB, comparing both approaches will help me understand SQL filtering more easily.

Let's look at some equivalent queries.

| Requirement | MySQL | MongoDB |
|---|---|---|
| Find all CSE students | `WHERE course = 'CSE'` | `{ course: "CSE" }` |
| Find student with ID 105 | `WHERE student_id = 105` | `{ student_id: 105 }` |
| Find students aged 20 | `WHERE age = 20` | `{ age: 20 }` |
| Find missing phone values | `phone IS NULL` | `{ phone: null }` |
| Find names starting with R | `name LIKE 'R%'` | `{ name: /^R/ }` |
| Match multiple courses | `course IN ('CSE', 'IT')` | `{ course: { $in: ["CSE", "IT"] } }` |

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

## 11. Practical Understanding: School Management System

Now let's connect everything to the database I'm building throughout this course.

Imagine my School Management System has a `students` table with additional columns such as `phone` and `email`.

The college administration might have different requirements:

### Situation 1: Find all students enrolled in CSE.

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

### Situation 2: Find the student whose ID is 104.

```sql
SELECT *
FROM students
WHERE student_id = 104;
```

### Situation 3: Display the names of students who are 20 years old.

```sql
SELECT name
FROM students
WHERE age = 20;
```

### Situation 4: Find students who haven't provided their phone number.

```sql
SELECT *
FROM students
WHERE phone IS NULL;
```

### Situation 5: Find students whose names start with R.

```sql
SELECT *
FROM students
WHERE name LIKE 'R%';
```

### Situation 6: Find students enrolled in CSE, IT, or ECE.

```sql
SELECT *
FROM students
WHERE course IN ('CSE', 'IT', 'ECE');
```

### Situation 7: Find students who are not enrolled in CSE or IT.

```sql
SELECT *
FROM students
WHERE course NOT IN ('CSE', 'IT');
```

Each query retrieves only the records that match the specified condition.

This is how I can retrieve meaningful information from a database instead of blindly fetching every record.

## Quick Revision

| Concept | Meaning |
|---|---|
| `WHERE` | Filters records based on a condition |
| `IS NULL` | Finds records containing NULL values |
| `IS NOT NULL` | Finds records that have a value |
| `LIKE` | Searches text using a pattern |
| `NOT LIKE` | Excludes text matching a pattern |
| `%` | Matches zero or more characters |
| `_` | Matches exactly one character |
| `IN` | Matches any value in a specified list |
| `NOT IN` | Excludes values in a specified list |
| Text values | Generally written inside single quotes |
| Numeric values | Written without quotation marks |
| MongoDB `find()` | Retrieves documents matching a filter |

### Important Points to Remember

1. `WHERE` is used to filter rows in a table.
2. `SELECT` determines which columns appear in the result.
3. `WHERE` determines which rows are included in the result.
4. Text values are generally enclosed in single quotes.
5. Numeric values don't require quotation marks.
6. `NULL` is different from an empty string or zero.
7. Use `IS NULL` and `IS NOT NULL` to check for missing values.
8. Use `LIKE` with `%` and `_` to search text patterns.
9. Use `IN` instead of writing multiple equality conditions connected by `OR`.
10. Filtering data doesn't modify the original table.
11. If no records match the condition, MySQL returns an empty result set.
12. MongoDB's `find()` and SQL's `WHERE` provide similar filtering capabilities, but their syntax is different.

## What Should I Be Able to Explain After This Lesson?

Before moving ahead, I should be able to explain:

- What is the purpose of the `WHERE` clause?
- Why do I need filtering in SQL?
- What is the basic syntax of WHERE?
- How can I retrieve records matching a particular text or numeric value?
- Why do text values use quotation marks?
- What is the difference between `SELECT` and `WHERE`?
- What is `NULL`, and why can't I use `= NULL`?
- What is the difference between `IS NULL` and `IS NOT NULL`?
- How does `LIKE` work?
- What is the difference between `%` and `_`?
- What is the difference between `LIKE` and `NOT LIKE`?
- How does `IN` simplify multiple equality conditions?
- What is the difference between `IN` and `NOT IN`?
- How does SQL filtering compare with MongoDB's `find()`?
- Does filtering modify the original table?

## What's Next?

So far, I've learned how to filter records using different conditions.

But what if I want to retrieve students who are enrolled in CSE **and** are 20 years old?

Or students who belong to either CSE **or** IT?

A single condition isn't always enough. Sometimes I need to combine multiple conditions to retrieve exactly the records I want.

That's what I'll learn in the next lesson:

**L11 - Logical Operators**

I'll understand how `AND`, `OR`, and `NOT` help me combine and control multiple filtering conditions.