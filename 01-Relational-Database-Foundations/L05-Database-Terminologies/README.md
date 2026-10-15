# Lesson 05 — Database Terminologies: Understanding the Language of Databases

## Why Am I Learning This?

Before working deeply with MySQL, I need to understand the basic building blocks of a relational database.

Think about a school. It has students, teachers, classrooms, subjects, and attendance records. All this information needs to be stored somewhere in an organised way.

A database helps us do exactly that.

While learning MySQL, I'll frequently encounter terms like Database, DBMS, RDBMS, Schema, Table, Row, Column, Primary Key, Foreign Key, and Relationships.

Instead of memorising their definitions, I want to understand what each term actually represents, why it exists, and how everything connects.

For this lesson, I'll use a School Management System as an example to build my understanding.

## What Am I Going to Study?

I'll build my understanding in the following progression:

**1. Database Fundamentals**
- Database
- DBMS (Database Management System)
- RDBMS (Relational Database Management System)
- How MySQL fits into the picture

**2. Database Structure**
- Tables
- Rows (Records / Tuples)
- Columns (Fields / Attributes)
- Schema and Instance

**3. Keys in Relational Databases**
- Primary Key
- Foreign Key
- Candidate Key
- Alternate Key
- Composite Key

**4. Relationships Between Tables**
- One-to-One (1:1)
- One-to-Many (1:N)
- Many-to-Many (M:N)
- Junction Tables

**5. Other Important Concepts**
- NULL values
- Data Integrity
- Entity Integrity
- Referential Integrity
- Domain Integrity

**6. Putting Everything Together**
- Understand how these concepts work together in a School Management System.
- Build a mental model of how relational databases organise and connect information.

By the end of this lesson, I should be able to look at a relational database and understand its structure, terminology, and how its tables are connected.

---

## 1. Understanding the Big Picture

Let's start with a simple question:

**Where does an application store its data?**

Imagine I'm building a School Management System. It needs to store:

- Student information
- Teacher information
- Subject details
- Student attendance
- Examination results

I cannot keep all this information inside my JavaScript code. I need a proper system to store, organise, retrieve, and manage it.

This is where databases come in.

### Database

A **Database** is an organised collection of data that can be stored, accessed, managed, and updated efficiently.

For example, a school database might contain information about students, teachers, subjects, and attendance.

Think of a database as a digital storage room where information is organised instead of being scattered everywhere.

### DBMS (Database Management System)

Now, having a place to store data isn't enough. I also need a way to interact with that data.

That's where a **DBMS** comes in.

A Database Management System is software that allows us to create databases and perform operations such as:

- Inserting data
- Retrieving data
- Updating data
- Deleting data
- Managing access to data

Think of it this way:

- Database = The place where data is organised and stored.
- DBMS = The software that manages that data.

Examples of DBMS:

- MySQL
- PostgreSQL
- Oracle Database
- Microsoft SQL Server

### RDBMS (Relational Database Management System)

Not every database organises information in the same way.

An **RDBMS** is a type of DBMS that organises data into tables and establishes relationships between those tables.

For example, instead of storing everything in one huge table, a school database can have separate tables:

- students
- teachers
- subjects
- attendance

These tables can be connected using keys.

This is why it is called a relational database.

**Where does MySQL fit?**

MySQL is an RDBMS. It stores data in tables and allows us to establish relationships between them.

## 2. Understanding the Structure of a Database

Now that I understand what a database and RDBMS are, let's look inside a relational database.

Imagine I've created a database named `school_db`.

Inside it, I want to store information about students.

### Database

A database acts as a container for related information.

Example:

`school_db`

It can contain multiple tables, each responsible for storing a particular category of information.

### Table

A table is where related data is organised into rows and columns.

For example, I can create a table named `students`.

| student_id | name | age | course |
|---|---|---|---|
| 101 | John | 20 | CSE |
| 102 | Roman | 21 | ECE |
| 103 | Seth | 19 | CSE |

Here:

- `students` is the table name.
- Each row represents one student.
- Each column represents a particular attribute of a student.

Think of a table like an Excel sheet, where information is organised into rows and columns.

### Row (Record / Tuple)

A row represents one complete record in a table.

For example:

`101 | John | 20 | CSE`

This entire row represents one student.

Other names for a row include:

- Record
- Tuple

Whenever I insert a new student into the table, a new row is created.

### Column (Field / Attribute)

A column represents a particular property or characteristic of the data stored in a table.

For example:

- `student_id`
- `name`
- `age`
- `course`

Each column describes what kind of information should be stored for every student.

Other common terms:

- Field
- Attribute

**Remember the difference:**

- Row = One complete record.
- Column = One property of that record.

## 3. Understanding Schema and Instance

These two terms are important because they describe two different aspects of a database.

### Schema

A schema describes the structure or design of a database.

It defines things such as:

- Table names
- Column names
- Data types
- Relationships
- Constraints

For example, my `students` table might have this structure:

```sql
CREATE TABLE students (
    student_id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);
```

This definition describes the structure of the table.

It tells MySQL what columns exist and what kind of data they are intended to store.

Think of a schema as the blueprint of a house. It describes how the house is designed, not the people currently living inside it.

### Instance

An instance refers to the actual data stored in the database at a particular moment.

For example:

| student_id | name | age | course |
|---|---|---|---|
| 101 | John | 20 | CSE |
| 102 | Roman | 21 | ECE |

These are actual records stored inside the table.

If I insert another student, the instance changes, but the schema can remain exactly the same.

**The difference:**

- Schema = How the database is structured.
- Instance = What data is currently stored in it.

## 4. Understanding Keys

Now imagine that our school has thousands of students.

What happens if two students have the same name?

For example:

| name | age | course |
|---|---|---|
| John | 20 | CSE |
| John | 21 | ECE |

If I want to find a particular John, searching only by name can create confusion.

I need something that uniquely identifies each student.

This is where keys become important.

### Primary Key

A Primary Key is a column, or a combination of columns, that uniquely identifies every row in a table.

Example:

| student_id (PK) | name | age |
|---|---|---|
| 101 | John | 20 |
| 102 | John | 21 |
| 103 | Roman | 19 |

Here, `student_id` is the Primary Key.

Why?

- Every student has a unique ID.
- Two students cannot have the same Primary Key value.
- A Primary Key cannot contain NULL.
- A table can have only one Primary Key constraint, although it can contain multiple columns (composite primary key).

Think of it like a university roll number. Even if two students have the same name, their roll numbers distinguish them.

### Foreign Key

Now let's say I have another table called `attendance`.

| attendance_id | student_id | status |
|---|---|---|
| 1 | 101 | Present |
| 2 | 102 | Absent |
| 3 | 101 | Present |

Notice something?

The `student_id` column appears in both tables.

In the `students` table, `student_id` uniquely identifies a student.

In the `attendance` table, `student_id` refers to the student whose attendance is being recorded.

This is where a **Foreign Key** comes in.

A Foreign Key is a column (or group of columns) that references a key in another table, usually its Primary Key.

It helps establish relationships between tables and maintain referential integrity.

In our example:

- `students.student_id` = Primary Key.
- `attendance.student_id` = Foreign Key.

Think of a Foreign Key as a reference that connects one table to another.

### Candidate Key

A Candidate Key is a minimal column or combination of columns that can uniquely identify a record.

Imagine a student table containing:

- student_id
- university_email
- name
- age

Suppose both `student_id` and `university_email` are unique and neither needs another column to identify a student.

Both can be Candidate Keys.

We select one of them as the Primary Key. The remaining candidate keys are called Alternate Keys.

### Alternate Key

An Alternate Key is a Candidate Key that was not selected as the Primary Key.

For example:

- `student_id` = Primary Key.
- `university_email` = Alternate Key.

Both uniquely identify a student, but only one is chosen as the Primary Key.

### Composite Key

Sometimes, one column alone cannot uniquely identify a record.

For example, consider an `enrollments` table:

| student_id | subject_id | semester |
|---|---|---|
| 101 | 501 | 3 |
| 101 | 502 | 3 |
| 102 | 501 | 3 |

A student can enrol in multiple subjects, so `student_id` alone is not unique.

Similarly, many students can enrol in the same subject, so `subject_id` alone is not unique.

But the combination of `student_id` and `subject_id` can uniquely identify an enrollment in this example.

This combination is called a **Composite Key**.

## 5. Understanding Relationships

Now that I understand Primary Keys and Foreign Keys, I can understand how tables are connected.

In relational databases, tables are connected through relationships.

Let's understand the three common types.

### One-to-One (1:1)

One record in Table A is associated with one record in Table B, and vice versa.

Example:

- One student has one university ID card.
- One university ID card belongs to one student.

### One-to-Many (1:N)

One record in Table A can be associated with multiple records in Table B.

Example:

- One student can have multiple attendance records.
- Each attendance record belongs to one student.

This is a very common relationship in real-world applications.

### Many-to-Many (M:N)

Multiple records in Table A can be associated with multiple records in Table B.

Example:

- One student can enrol in multiple subjects.
- One subject can have multiple students.

To implement this relationship in a relational database, we generally introduce a junction table.

For example:

```text
students
   |
   | 1
   |
   | N
enrollments
   |
   | N
   |
   | 1
subjects
```

The `enrollments` table connects students and subjects using Foreign Keys.

## 6. Understanding NULL

One more important concept: NULL.

NULL represents a missing, unknown, or unavailable value.

Imagine this student record:

| student_id | name | phone |
|---|---|---|
| 101 | John | NULL |

Here, John's phone number is not available.

NULL does not mean:

- Zero
- An empty string
- A blank space

It means the value is missing or unknown.

For example, in SQL:

```sql
SELECT * FROM students
WHERE phone IS NULL;
```

Notice that we use `IS NULL`, not `= NULL`.

This is because NULL represents an unknown value, not an ordinary value that can be compared using equality.

## 7. Understanding Data Integrity

Imagine a school database where:

- Two students accidentally receive the same student ID.
- An attendance record refers to a student who doesn't exist.
- Someone enters a negative age.
- A required student name is left empty.

These problems make the database unreliable.

A database should maintain accurate, valid, and consistent data.

This is called **Data Integrity**.

Some important types are:

### Entity Integrity

Every row should be uniquely identifiable.

Primary Keys help maintain entity integrity because they must be unique and cannot contain NULL.

### Referential Integrity

References between related tables should remain valid.

For example, an attendance record should not refer to a student who doesn't exist.

Foreign Keys help maintain referential integrity.

### Domain Integrity

Values should follow the rules defined for a column.

For example:

- Age should be stored using an appropriate numeric data type.
- Student names should contain text.
- A required field should not accept NULL.

Data types and constraints help maintain domain integrity.

We'll study constraints and how MySQL enforces these rules in greater detail in upcoming lessons.

## 8. Connecting Everything Together

Let's bring everything we've learned into one picture.

Imagine I'm building a School Management System.

```text
                    SCHOOL DATABASE
                           |
                        school_db
                           |
              +------------+------------+
              |            |            |
           students     subjects     teachers
              |
              | student_id (PK)
              |
              v
          attendance
              |
              | student_id (FK)
              |
              v
           students
```

Each table stores a particular type of information.

Rows represent individual records, columns represent attributes, Primary Keys identify records, and Foreign Keys connect related tables.

This is the basic foundation of a relational database.

## 9. Quick Revision

| Terminology | What it means |
|---|---|
| Database | Organised collection of data |
| DBMS | Software used to manage databases |
| RDBMS | DBMS that organises data using related tables |
| Schema | Structure or blueprint of a database |
| Instance | Actual data at a particular moment |
| Table | Data organised into rows and columns |
| Row | One complete record |
| Column | One attribute of a record |
| Primary Key | Uniquely identifies a record |
| Foreign Key | References a key in another table |
| Candidate Key | Minimal set of attributes that uniquely identifies a record |
| Alternate Key | Candidate Key not selected as the Primary Key |
| Composite Key | Key consisting of multiple columns |
| NULL | Missing or unknown value |
| Relationship | Connection between tables |
| Data Integrity | Accuracy and consistency of stored data |

## 10. What Should I Be Able to Explain After This Lesson?

Before moving forward, I should be able to explain these concepts in my own words:

1. What is the difference between a Database, DBMS, and RDBMS?
2. What is the difference between a table, row, and column?
3. What is the difference between Schema and Instance?
4. Why do we need Primary Keys?
5. How does a Foreign Key connect two tables?
6. What is the difference between Candidate Key and Primary Key?
7. What is a Composite Key, and when do we need one?
8. What are One-to-One, One-to-Many, and Many-to-Many relationships?
9. Why is NULL different from zero and an empty string?
10. What is Data Integrity, and why does it matter?

If I can explain these without simply memorising definitions, I've understood the foundation of relational databases.

---

## What's Next?

Now that I understand the language and structure of relational databases, I can move towards understanding how actual data is represented and stored.

**Lesson 06 — MySQL Data Types**

I'll learn how MySQL decides what kind of information each column can store, why choosing the correct data type matters, and how different data types affect storage and operations.

The goal is to understand not just which data types exist, but also when and why I should use them.