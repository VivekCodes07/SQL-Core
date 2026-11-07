# L11 - Logical Operators (AND, OR, NOT)

## Why Am I Learning This?

In the previous lesson, I learned how to filter records using the `WHERE` clause.

For example:

```sql
SELECT *
FROM students
WHERE course = 'CSE';
```

This query retrieves students enrolled in CSE.

But imagine I'm building a School Management System. Now I want to find:

- Students enrolled in CSE who also live in Delhi.
- Students enrolled in either CSE or IT.
- Students who are not enrolled in CSE.

A single condition isn't enough for these situations.

I need a way to combine multiple conditions and control how MySQL evaluates them.

That's why I'm learning **Logical Operators**.

## What Am I Going to Study?

1. What are Logical Operators?
2. AND Operator
3. OR Operator
4. NOT Operator
5. Combining multiple conditions
6. Understanding AND vs OR
7. SQL Logical Operators vs MongoDB
8. Real-world backend examples

## 1. What Are Logical Operators?

Logical operators allow me to combine multiple conditions or reverse the result of a condition.

MySQL provides three commonly used logical operators:

| Operator | Meaning |
|---|---|
| `AND` | All conditions must be true |
| `OR` | At least one condition must be true |
| `NOT` | Reverses the result of a condition |

Let's understand each one using our existing `students` table.

Our sample records look like this:

| student_id | name | age | course | city |
|---|---|---|---|---|
| 1 | John | 20 | CSE | Delhi |
| 2 | Roman | 21 | IT | Mumbai |
| 3 | Seth | 19 | CSE | Chandigarh |
| 4 | Randy | 22 | ECE | Pune |
| 5 | Brock | 20 | Mechanical | Jaipur |

## 2. AND Operator

### Why do I need AND?

Suppose I want to find students who are enrolled in CSE and also live in Delhi.

Checking only the course isn't enough. Checking only the city isn't enough either.

I need both conditions to be satisfied.

That's where `AND` comes in.

### How does AND work?

`AND` returns a record only when **all the specified conditions are true**.

Think of it like this:

```text
Condition 1 AND Condition 2

TRUE  AND TRUE  = TRUE
TRUE  AND FALSE = FALSE
FALSE AND TRUE  = FALSE
FALSE AND FALSE = FALSE
```

### SQL Example

```sql
SELECT *
FROM students
WHERE course = 'CSE'
AND city = 'Delhi';
```

**What is MySQL doing here?**

For every student, MySQL checks:

1. Is the student's course CSE?
2. Does the student live in Delhi?
3. If both answers are true, return that student's record.

**Expected Output:**

| student_id | name | age | course | city |
|---|---|---|---|---|
| 1 | John | 20 | CSE | Delhi |

Only John satisfies both conditions.

### Another Example

Find students who are 20 years old and enrolled in CSE.

```sql
SELECT *
FROM students
WHERE age = 20
AND course = 'CSE';
```

**Expected Output:**

No records.

Why? John is 20 but enrolled in CSE, so he actually satisfies both conditions.

Correction: John matches both conditions, so the result is:

| student_id | name | age | course | city |
|---|---|---|---|---|
| 1 | John | 20 | CSE | Delhi |

The important thing is that every condition connected by `AND` must be satisfied.

## 3. OR Operator

### Why do I need OR?

Now suppose I want to find students who are enrolled in either CSE or IT.

I don't want both conditions to be true for the same student.

I just need a student to belong to at least one of these courses.

That's where `OR` comes in.

### How does OR work?

`OR` returns a record when **at least one of the specified conditions is true**.

```text
Condition 1 OR Condition 2

TRUE  OR TRUE  = TRUE
TRUE  OR FALSE = TRUE
FALSE OR TRUE  = TRUE
FALSE OR FALSE = FALSE
```

### SQL Example

```sql
SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT';
```

**What is MySQL doing here?**

For every student, MySQL checks:

1. Is the student's course CSE?
2. Is the student's course IT?
3. If either condition is true, return the record.

**Expected Output:**

| student_id | name | age | course | city |
|---|---|---|---|---|
| 1 | John | 20 | CSE | Delhi |
| 2 | Roman | 21 | IT | Mumbai |
| 3 | Seth | 19 | CSE | Chandigarh |

Notice that all three students are returned because each one satisfies at least one condition.

### Another Example

Find students who live in Delhi or Mumbai.

```sql
SELECT *
FROM students
WHERE city = 'Delhi'
OR city = 'Mumbai';
```

**Expected Output:**

John and Roman.

Even though they live in different cities, both records satisfy one of the conditions.

## 4. NOT Operator

### Why do I need NOT?

Suppose I want to retrieve all students who are not enrolled in CSE.

I could manually specify every other course, but that would become inconvenient if the database had many courses.

Instead, I can simply reverse the condition.

That's what `NOT` does.

### How does NOT work?

`NOT` reverses the result of a condition.

```text
NOT TRUE  = FALSE
NOT FALSE = TRUE
```

### SQL Example

```sql
SELECT *
FROM students
WHERE NOT course = 'CSE';
```

**What is MySQL doing here?**

It checks whether the student's course is CSE.

- If the condition is true, NOT reverses it to false.
- If the condition is false, NOT reverses it to true.

Therefore, students enrolled in courses other than CSE are returned.

**Expected Output:**

| student_id | name | age | course | city |
|---|---|---|---|---|
| 2 | Roman | 21 | IT | Mumbai |
| 4 | Randy | 22 | ECE | Pune |
| 5 | Brock | 20 | Mechanical | Jaipur |

Another way to write the same query is:

```sql
SELECT *
FROM students
WHERE NOT (course = 'CSE');
```

The parentheses make the condition being reversed easier to understand.

## 5. Combining Multiple Logical Operators

Now let's make things a little more interesting.

Suppose I want to find students who:

- Are enrolled in CSE or IT.
- And live in Delhi.

I need to combine `OR` and `AND`.

### SQL Example

```sql
SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'IT')
AND city = 'Delhi';
```

**Why did I use parentheses?**

Because I want MySQL to evaluate the course conditions together first.

The logic is:

```text
                 AND
                /   \
              OR   city = Delhi
             /  \
     course = CSE  course = IT
```

First, MySQL checks whether the student belongs to CSE or IT.

Then it checks whether the student lives in Delhi.

Both parts must be satisfied.

**Expected Output:**

| student_id | name | age | course | city |
|---|---|---|---|---|
| 1 | John | 20 | CSE | Delhi |

### Understanding Operator Precedence

What happens if I don't use parentheses?

```sql
SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT'
AND city = 'Delhi';
```

MySQL evaluates `AND` before `OR`.

So this is interpreted as:

```sql
WHERE course = 'CSE'
OR (course = 'IT' AND city = 'Delhi');
```

This is different from the previous query!

To avoid unexpected results, I should use parentheses whenever combining multiple logical operators.

## 6. SQL Logical Operators vs MongoDB

Since I've already worked with MongoDB, I can connect these concepts to something I know.

In MongoDB, I use query operators to combine multiple conditions.

### AND in SQL vs MongoDB

**SQL:**

```sql
SELECT *
FROM students
WHERE course = 'CSE'
AND city = 'Delhi';
```

**MongoDB:**

```javascript
db.students.find({
  course: "CSE",
  city: "Delhi"
});
```

MongoDB implicitly combines these field conditions using AND.

I can also use the explicit `$and` operator:

```javascript
db.students.find({
  $and: [
    { course: "CSE" },
    { city: "Delhi" }
  ]
});
```

### OR in SQL vs MongoDB

**SQL:**

```sql
SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'IT';
```

**MongoDB:**

```javascript
db.students.find({
  $or: [
    { course: "CSE" },
    { course: "IT" }
  ]
});
```

### NOT in SQL vs MongoDB

**SQL:**

```sql
SELECT *
FROM students
WHERE NOT (course = 'CSE');
```

**MongoDB:**

```javascript
db.students.find({
  course: { $ne: "CSE" }
});
```

Here, MongoDB uses `$ne` (not equal) to find documents whose course is not CSE. This is a similar filtering result, although it isn't a direct syntax equivalent of SQL's `NOT`.

The important difference is:

- SQL works with tables and rows.
- MongoDB works with collections and documents.
- Both allow me to combine conditions to retrieve the data I need.

## 7. How Will I Use This in Backend Development?

Imagine I'm building a student management API using Node.js, Express, and MySQL.

A user visits an endpoint to find students enrolled in CSE who live in Delhi.

My backend can execute:

```sql
SELECT *
FROM students
WHERE course = 'CSE'
AND city = 'Delhi';
```

The database returns only matching records, and my Express API can send those records as a JSON response.

This is how logical operators help build real-world filtering features such as:

- Searching students by course and city.
- Finding users who meet multiple requirements.
- Filtering products by category or availability.
- Retrieving orders that match different conditions.

## Quick Revision

| Operator | What it does | Example |
|---|---|---|
| `AND` | All conditions must be true | `course = 'CSE' AND city = 'Delhi'` |
| `OR` | At least one condition must be true | `course = 'CSE' OR course = 'IT'` |
| `NOT` | Reverses a condition | `NOT (course = 'CSE')` |

Remember:

- `AND` makes filtering more restrictive.
- `OR` allows more records to match.
- `NOT` reverses a condition.
- `AND` has higher precedence than `OR`.
- Parentheses help control the order in which conditions are evaluated.

## What Should I Be Able to Explain After This Lesson?

After completing this lesson, I should be able to explain:

1. Why do we need logical operators?
2. How does `AND` differ from `OR`?
3. How does `NOT` reverse a condition?
4. How can I combine multiple conditions in a single query?
5. Why are parentheses important when combining `AND` and `OR`?
6. How do SQL logical operators compare with MongoDB query operators?

## What's Next?

In the next lesson, I'll learn **L12 - Comparison Operators**.

So far, I've mostly checked whether values are equal. But real applications need more flexible comparisons.

For example:

- Find students older than 20.
- Find students whose age is less than 21.
- Find records where a value is not equal to something.

I'll learn operators such as `=`, `!=`, `<>`, `>`, `<`, `>=`, and `<=` in the next lesson.