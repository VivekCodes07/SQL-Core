# Lesson 06 — MySQL Data Types: Choosing the Right Type for Real Applications

## Why Am I Learning This?

Imagine I am building the backend of an e-commerce application.

Users can create accounts, browse products, place orders, make payments, and track deliveries. To support all these features, I need a database that can store different kinds of information correctly.

For example, a product might have the following information:

```text
Product
|
|-- id                 501
|-- name               "Mechanical Keyboard"
|-- price              2499.99
|-- stock_quantity     120
|-- discount_percent   12.50
|-- is_available       TRUE
|-- created_at         2026-10-14 10:30:00
```

Now think about these values.

- The product ID is a whole number.
- The product name is text.
- The price needs decimal precision.
- The stock quantity is a whole number that should not be negative.
- The discount percentage contains decimal places.
- The availability status represents a true-or-false concept.
- The creation time represents a date and time.

Should I store all these values using the same data type?

Obviously not.

A database needs to understand the difference between these values so it can represent them appropriately, perform calculations, compare them, and enforce the rules defined for the application.

This is where MySQL data types come in.

**A data type defines how a column represents its values and which kinds of values it can store.**

Choosing a suitable type is not just a storage decision. It also affects precision, valid ranges, query behavior, and the correctness of my application.

For example, choosing `FLOAT` for money can introduce approximate floating-point results. Choosing a type that is too small for an inventory count can cause values to exceed its supported range. Storing dates as arbitrary strings makes date operations more difficult and less reliable.

I want to understand the reasoning behind these choices so that when I design a database for my own backend projects, I don't have to choose types blindly.

## What Am I Going to Learn?

By the end of this lesson, I want to understand:

1. What a data type does when I define a table.
2. Numeric types: integers, exact decimals, and approximate numbers.
3. String types: `CHAR`, `VARCHAR`, `BINARY`, `VARBINARY`, and the text families.
4. Date and time types, including the differences between `DATETIME` and `TIMESTAMP`.
5. Boolean values and how MySQL represents them.
6. Binary large objects and when binary storage is appropriate.
7. The native `JSON` type and when JSON makes sense in a relational database.
8. Important details such as `NULL`, signed versus unsigned numbers, precision, scale, length, and character sets.
9. How to choose suitable data types for a real application.
10. How to inspect a table's structure and experiment with these types in MySQL.

---

# 1. First Principles — What Does a Data Type Actually Do?

Before learning individual types, I want to understand where they fit in a table definition.

Consider this statement:

```sql
CREATE TABLE products (
    id INT,
    name VARCHAR(150),
    price DECIMAL(10,2),
    stock_quantity INT UNSIGNED,
    created_at DATETIME
);
```

I am defining five columns, and each column has a data type.

```text
products
|
+-- id              -> INT
+-- name            -> VARCHAR(150)
+-- price           -> DECIMAL(10,2)
+-- stock_quantity  -> INT UNSIGNED
+-- created_at      -> DATETIME
```

The type tells MySQL how to interpret values in that column.

But notice something important.

```sql
stock_quantity INT UNSIGNED
```

This defines an unsigned integer. It does not automatically establish every rule I might need for inventory management.

For example, I may want stock quantities to be no greater than 100,000. I may also want the quantity to be mandatory. These are additional rules, handled through constraints.

Similarly, `price DECIMAL(10,2)` defines a numeric representation with a particular precision and scale. It does not automatically prevent negative prices.

I will learn more about constraints in later lessons. For now, I need to keep these two ideas separate:

```text
Column definition
       |
       +-- Data type
       |      What kind of value can this column represent?
       |
       +-- Constraints
              What rules must the value follow?
```

## How do I choose a data type?

I should start with the meaning of the information, not with the list of available types.

For every column, I can ask:

1. What does this value represent?
2. Is it a number, text, date, time, binary value, or structured document?
3. What range or length must it support?
4. Does it require exact decimal precision?
5. Does the application need additional rules?

With that foundation, I can explore each data type family.

---

# 2. Numeric Data Types

Numeric types are used whenever an application needs to represent numbers.

However, not all numbers behave the same way.

An e-commerce application might store:

- Product IDs
- Stock quantities
- Order counts
- Product prices
- Tax amounts
- Discounts
- Product dimensions
- Scientific measurements

Some require whole numbers. Others require exact decimal values. Some calculations are naturally represented using approximate floating-point numbers.

MySQL provides different numeric types for these requirements.

## 2.1 Integer Types — Whole Numbers

Integer types represent whole numbers without a fractional part.

Examples include:

```text
501
120
4500
3
```

In an e-commerce application, I might use integers for product identifiers, inventory quantities, and the number of items in an order.

MySQL provides five main integer types.

| Type | Storage | Signed range |
|---|---:|---:|
| `TINYINT` | 1 byte | -128 to 127 |
| `SMALLINT` | 2 bytes | -32,768 to 32,767 |
| `MEDIUMINT` | 3 bytes | -8,388,608 to 8,388,607 |
| `INT` | 4 bytes | -2,147,483,648 to 2,147,483,647 |
| `BIGINT` | 8 bytes | -2⁶³ to 2⁶³ − 1 |

These are the ranges for signed integer types.

The important pattern is that larger types support larger ranges but use more storage.

### `TINYINT`

`TINYINT` is a small integer type.

It can be useful for values with a genuinely small range, such as a small counter or a numeric rating.

```sql
rating TINYINT
```

However, the type itself does not know that a product rating should be between 1 and 5. A separate constraint is needed to enforce that rule.

### `SMALLINT`

`SMALLINT` supports a larger range than `TINYINT`.

It can be useful for values that may exceed the smaller range but do not require the range of `INT`.

```sql
small_counter SMALLINT
```

### `MEDIUMINT`

`MEDIUMINT` sits between `SMALLINT` and `INT`.

It is useful to recognize, although many applications can use `INT` instead without needing this intermediate range.

```sql
regional_stock MEDIUMINT UNSIGNED
```

### `INT`

`INT` is a common general-purpose integer type.

It is often suitable for identifiers, counts, and quantities when its range meets the application's requirements.

```sql
product_id INT
stock_quantity INT
order_item_count INT
```

### `BIGINT`

`BIGINT` supports a much larger integer range.

It may be appropriate for extremely large counters or identifiers when `INT` is insufficient.

```sql
event_count BIGINT
```

I should not automatically use `BIGINT` everywhere. The correct choice depends on the values the application needs to support.

## 2.2 Signed vs Unsigned Integers

By default, integer types are signed, meaning they can represent negative and positive values.

For example:

```sql
quantity INT
```

An ordinary signed `INT` supports negative values.

But does negative stock make sense for a simple inventory system?

Usually, no.

I could use:

```sql
quantity INT UNSIGNED
```

An unsigned integer cannot represent negative values.

For example, an unsigned `TINYINT` supports:

```text
0 through 255
```

Compare that with the signed range:

```text
-128 through 127
```

The unsigned type allocates its entire range to non-negative values.

### When is `UNSIGNED` useful?

It can be useful for quantities and counters that should never be negative.

However, it is important to understand its limitations.

`UNSIGNED` does not mean "any non-negative number." The type still has a maximum supported value.

It also does not replace business rules. If stock must remain below 100,000, I still need to enforce that limit separately.

Another practical consideration is compatibility: foreign-key columns must use compatible definitions, including relevant integer attributes, and signedness should be planned consistently across related tables.

**My takeaway:** choose an integer type according to the required range, and consider `UNSIGNED` when negative values genuinely have no meaning.

## 2.3 `DECIMAL` — Exact Decimal Values

Now imagine I am storing the price of a product.

```text
2499.99
```

This value represents money. I need decimal arithmetic that does not introduce the ordinary approximation associated with binary floating-point types.

This is where `DECIMAL` becomes important.

Consider:

```sql
price DECIMAL(10,2)
```

The syntax contains two numbers:

```text
DECIMAL(10,2)
        |  |
        |  +-- Scale: digits after the decimal point
        +----- Precision: total number of digits
```

For `DECIMAL(10,2)`:

- Precision is 10.
- Scale is 2.
- Up to 8 digits can appear before the decimal point.
- Up to 2 digits can appear after it.

The maximum positive value is:

```text
99999999.99
```

Other examples:

```text
2499.99
 125.50
   0.25
```

This makes `DECIMAL` suitable for many financial values.

### Where might I use `DECIMAL`?

```sql
product_price DECIMAL(10,2)
tax_amount DECIMAL(10,2)
discount_amount DECIMAL(10,2)
```

The actual precision and scale should match the application's requirements.

For example, a system that stores currencies with different minor-unit precision may need a different design. A system that handles very large totals may need greater precision.

### What happens if I store a percentage?

Suppose a product has a discount of 12.50%.

```sql
discount_percent DECIMAL(5,2)
```

This can represent:

```text
12.50
 7.25
 0.00
```

But it can also represent values greater than 100. The data type does not know what a percentage means.

If the application permits discounts only from 0 through 100, I need a suitable constraint.

This is an important pattern: **the type represents the value; the business rule restricts what that value is allowed to mean.**

## 2.4 `FLOAT` and `DOUBLE` — Approximate Numeric Values

Now imagine an application needs to store physical measurements or perform scientific calculations.

MySQL provides floating-point types:

- `FLOAT`
- `DOUBLE`

Both represent approximate numeric values.

`FLOAT` uses single-precision floating-point representation, while `DOUBLE` uses double precision and generally provides more precision.

Why are these values approximate?

Computers represent floating-point numbers using binary fractions. Some decimal fractions cannot be represented exactly as finite binary fractions.

For example, the decimal number `0.1` does not have an exact finite binary floating-point representation.

Consequently, calculations can produce results that differ slightly from the decimal result I expected.

That does not mean floating-point types are defective. It means they are designed for approximate numeric representation.

### When should I use them?

They can be appropriate for scientific measurements, engineering calculations, and other applications where floating-point behavior is suitable.

For financial amounts, I would generally start with `DECIMAL` or an explicitly designed integer-minor-unit representation.

| Requirement | Type to consider |
|---|---|
| Product prices and financial amounts | `DECIMAL` |
| Whole-number inventory quantities | `INT` or another integer type |
| Very large whole-number counters | `BIGINT` |
| Scientific measurements | `FLOAT` or `DOUBLE`, depending on precision needs |

I should choose the type according to the mathematical properties the application requires.

## 2.5 `BIT` — Bit Values

MySQL also provides the `BIT` type.

It stores bit values and can be declared with a bit length.

```sql
feature_flags BIT(4)
```

A four-bit value can represent 16 different patterns, from `0000` through `1111`.

This can be useful in specialized cases involving bit fields or compact binary flags.

However, I should not automatically choose `BIT` for every true-or-false column. In ordinary application code, `BOOLEAN` is usually clearer when I simply want to express a logical state.

---

# 3. String Data Types

An e-commerce application needs to store text such as:

- Usernames
- Email addresses
- Product names
- Product descriptions
- Order reference codes
- Addresses
- Country codes

These values are not all the same length.

A country code is short and predictable. A product description can be much longer.

MySQL provides different string types for these situations.

## 3.1 `CHAR` — Fixed-Length Character Fields

Consider a country code.

```text
IN
US
GB
```

If my application uses two-character country codes, I could define:

```sql
country_code CHAR(2)
```

`CHAR(2)` declares a fixed-length character field with a length of two characters.

Shorter values are padded with spaces for storage, and trailing-space handling can depend on the operation and SQL mode.

This type can be useful when values have a consistent, short length.

Examples might include fixed-format codes whose length is guaranteed by the application.

However, `CHAR` is not automatically better just because a column has a maximum length.

## 3.2 `VARCHAR` — Variable-Length Character Fields

Now consider product names:

```text
Mouse
Mechanical Keyboard
Wireless Noise Cancelling Headphones
```

Their lengths vary considerably.

A declaration such as:

```sql
product_name VARCHAR(200)
```

allows values up to 200 characters, subject to MySQL's limits and the table's character set.

It does not require every product name to contain 200 characters.

Other examples:

```sql
username VARCHAR(50)
email VARCHAR(254)
order_reference VARCHAR(40)
```

These lengths are illustrative design choices. A production system should select limits that fit its actual requirements.

### `CHAR` vs `VARCHAR`

| Feature | `CHAR(n)` | `VARCHAR(n)` |
|---|---|---|
| Length behavior | Fixed-length field | Variable-length field |
| Suitable for | Short, consistent-length values | Values with varying lengths |
| Examples | Certain fixed-format codes | Names, emails, product titles |
| Storage behavior | Space-padded | Value length plus length metadata |

There is one more detail worth understanding.

`VARCHAR(n)` defines a maximum character length, not a fixed number of bytes. The actual storage required depends on the character set and the characters stored.

For example, Unicode characters may require multiple bytes.

I should choose `CHAR` or `VARCHAR` based on the nature of the data, rather than assuming that one is always faster or more efficient.

## 3.3 `TEXT` Types — Longer Text Content

A product name and a product description have different requirements.

A name might be:

```text
Mechanical Keyboard
```

A description might contain several paragraphs explaining its features, compatibility, and specifications.

For longer text, MySQL provides these types:

| Type | Maximum data length |
|---|---:|
| `TINYTEXT` | 255 bytes |
| `TEXT` | 65,535 bytes |
| `MEDIUMTEXT` | 16,777,215 bytes |
| `LONGTEXT` | 4,294,967,295 bytes |

These limits are expressed in bytes, not necessarily characters. The number of characters a value can contain depends on its character set.

For example:

```sql
product_description TEXT
```

This is a reasonable starting point for many product descriptions.

For substantially larger content, a different text type may be appropriate.

However, I should not choose `LONGTEXT` merely because it has the largest capacity. The type should fit the application's actual needs, and very large content may be better stored outside the database.

## 3.4 `ENUM` — A Value From a Defined Set

Sometimes a column should contain one value from a predefined set.

For example, an order might have a status:

```text
pending
confirmed
shipped
delivered
cancelled
```

MySQL provides `ENUM` for this purpose.

```sql
status ENUM(
    'pending',
    'confirmed',
    'shipped',
    'delivered',
    'cancelled'
)
```

The column is designed to accept one of the listed values.

This can be convenient when the allowed set is small and stable.

However, I should think carefully before using it for every status column.

If statuses need to be managed dynamically, have additional metadata, or participate in a larger workflow, a separate status table with a foreign key may be more flexible.

For a real backend application, the choice depends on how the statuses are managed and how likely they are to change.

## 3.5 `SET` — Multiple Values From a Defined Set

MySQL also provides `SET`.

It allows a column to contain zero or more values selected from a predefined set.

For example:

```sql
permissions SET(
    'read',
    'write',
    'delete'
)
```

A value could contain more than one of the listed options.

However, `SET` is less suitable when the values represent independent relationships or when the set of options changes frequently.

If a user can have several permissions in a real application, a separate permissions table and a user-permissions relationship table are often a more flexible relational design.

I should recognize `SET` as a MySQL feature, but I should not assume it is the best database design for every multi-value requirement.

## 3.6 Character Sets and Collations

String data types have another important consideration: how MySQL represents and compares text.

A **character set** defines the characters that can be represented and how they are encoded.

A **collation** defines rules for comparing and sorting strings.

For example, an application might store names containing characters from many languages.

Using a suitable Unicode character set, such as `utf8mb4`, helps support a broad range of Unicode characters.

Collations can also affect whether string comparisons are case-sensitive or accent-sensitive.

For example, depending on the collation, comparisons involving `Keyboard` and `keyboard` may treat them as equal or different.

This matters when designing usernames, email-related comparisons, product searches, and sorting behavior.

For now, I should remember:

- Character set: which characters can be represented and how.
- Collation: how strings are compared and sorted.

These choices can affect real application behavior, not just storage.

---

# 4. Binary Data Types

So far, I have mostly discussed numbers and text.

But sometimes an application needs to store data that should be treated as bytes rather than ordinary text.

MySQL provides several binary types.

## 4.1 `BINARY` and `VARBINARY`

These types are similar in concept to `CHAR` and `VARCHAR`, but they represent binary byte strings.

| Type | Behavior |
|---|---|
| `BINARY(n)` | Fixed-length binary data |
| `VARBINARY(n)` | Variable-length binary data |

They can be useful when storing binary identifiers or other byte sequences.

For example, a system may represent a UUID in a compact binary format rather than as a 36-character textual UUID.

```sql
identifier BINARY(16)
```

Whether this is a good choice depends on how the application generates, stores, and queries its identifiers.

## 4.2 `BLOB` Types

`BLOB` stands for Binary Large Object.

MySQL provides several BLOB sizes:

| Type | Maximum data length |
|---|---:|
| `TINYBLOB` | 255 bytes |
| `BLOB` | 65,535 bytes |
| `MEDIUMBLOB` | 16,777,215 bytes |
| `LONGBLOB` | 4,294,967,295 bytes |

These types are designed for binary data rather than character text.

Examples may include images, documents, or other binary content.

However, storing every uploaded file directly in a relational database is not always the best architecture.

A common backend design is to store files in object storage and save their URLs or object keys, together with metadata, in the database.

This reduces the amount of large binary content that the database must manage.

The important distinction is that BLOB types are available when binary storage inside MySQL is appropriate, but they do not mean every file should live in a database table.

---

# 5. Date and Time Types

E-commerce applications need to know when events happen.

Examples include:

- When a user registered
- When an order was placed
- When a payment was processed
- When a package was delivered
- When a product was added to the catalogue

These values are not ordinary strings. MySQL has dedicated temporal types for representing dates and times.

## 5.1 The Main Temporal Types

| Type | What it represents | Example |
|---|---|---|
| `DATE` | Calendar date | `2026-10-14` |
| `TIME` | Time of day or time interval | `14:30:00` |
| `DATETIME` | Date and time | `2026-10-14 14:30:00` |
| `TIMESTAMP` | Date and time with session-time-zone conversion behavior | `2026-10-14 14:30:00` |
| `YEAR` | Year value | `2026` |

## 5.2 `DATE`

If I only need to store a date, such as a product's launch date, I can use:

```sql
launch_date DATE
```

I do not need to store an hour, minute, or second.

## 5.3 `TIME`

Suppose an application stores a delivery window or a daily opening time.

```sql
delivery_start_time TIME
```

A value could look like:

```text
09:30:00
```

One detail to remember is that MySQL's `TIME` type can also represent time intervals, including durations beyond an ordinary 24-hour clock.

If the application needs a date as well, I must choose a type that represents both.

## 5.4 `DATETIME`

For an order placement time, I might use:

```sql
order_placed_at DATETIME
```

A value could be:

```text
2026-10-14 14:30:00
```

This contains both a date and a time.

`DATETIME` does not perform the automatic session-time-zone-to-UTC conversion associated with `TIMESTAMP`.

## 5.5 `TIMESTAMP`

`TIMESTAMP` is often useful for recording event times that need time-zone conversion behavior.

MySQL converts `TIMESTAMP` values between the session time zone and UTC when storing and retrieving them.

This makes the distinction important in applications used across different time zones.

For example, suppose a customer in India places an order while a support engineer in another country views the same record.

The application needs a consistent strategy for representing the event's actual time and displaying it appropriately to each user.

I should not choose `TIMESTAMP` or `DATETIME` without understanding that requirement.

Also, their supported ranges differ. MySQL `TIMESTAMP` has a more limited range than `DATETIME`, so the required dates matter too.

## 5.6 `YEAR`

`YEAR` stores year values.

It can be useful for data such as a product model year or another field whose meaning is genuinely just a year.

For many applications, a full `DATE` is more appropriate when the month and day are meaningful.

## Choosing a date/time type

```text
What does the value represent?
          |
          +-- Only a calendar date
          |       |
          |       +--> DATE
          |
          +-- A time or duration
          |       |
          |       +--> TIME
          |
          +-- A date and time
                  |
                  +--> Consider DATETIME or TIMESTAMP
```

The final choice depends on the meaning of the data, time-zone requirements, and the supported date range.

---

# 6. Boolean Values

An e-commerce application needs many true-or-false states:

- Is a product active?
- Is an account verified?
- Is an order paid?
- Is a product available for purchase?

A Boolean-style column expresses this kind of information.

For example:

```sql
is_active BOOLEAN
```

In MySQL, `BOOLEAN` is an alias for `TINYINT(1)`, rather than a separate native Boolean storage type.

The usual representation is:

```text
TRUE  -> 1
FALSE -> 0
```

However, declaring a column as `BOOLEAN` does not automatically restrict every stored value to `0` or `1`. If I need that rule enforced, I should add an appropriate constraint.

There is another important detail: `NULL` is not the same as `FALSE`.

For example, an unknown payment status is conceptually different from a payment explicitly marked as unpaid.

I should choose whether `NULL` is permitted according to the application's requirements.

---

# 7. JSON Data Type

Modern backend applications sometimes receive or store structured data whose shape varies between records.

For example, a product might have additional attributes:

```json
{
  "material": "aluminium",
  "wireless": true,
  "battery_life_hours": 40
}
```

Another product might have a different set of attributes.

MySQL supports a native `JSON` type for storing JSON documents.

For example:

```sql
CREATE TABLE product_metadata (
    product_id INT,
    attributes JSON
);
```

The `attributes` column can store a JSON document.

MySQL validates values stored in a native JSON column as JSON documents and provides functions for querying and manipulating their contents.

However, flexibility does not mean JSON should replace relational design.

Consider two kinds of information:

- A product's optional technical specifications may fit naturally into JSON.
- A customer's orders should normally be represented using relational tables and relationships.

If I need to enforce relationships between entities, use foreign keys, or query a value as a core part of the application's data model, regular columns and related tables may be better choices.

I should use JSON when the document structure is genuinely useful—not simply because it allows different fields in different records.

---

# 8. `NULL` Is Not a Data Type

I want to understand one more concept before designing the complete schema.

Consider a user table containing an optional phone number.

```sql
phone_number VARCHAR(20) NULL
```

The `NULL` keyword here means the column is permitted to contain a missing or unknown value.

It does not mean the data type is `NULL`.

The data type is `VARCHAR(20)`. The column's nullability is a separate property.

These values are different:

| Value | Meaning |
|---|---|
| `0` | Numeric zero |
| `''` | An empty string |
| `' '` | A string containing a space |
| `NULL` | Missing or unknown value |

This distinction matters in real applications.

For example, a product's stock quantity being zero is not the same as the stock quantity being unknown.

Similarly, an optional phone number being `NULL` is not the same as storing an empty string.

I will study `NULL` behavior in queries more deeply when I reach filtering and logical operators.

For now, I should remember that the data type, nullability, and business meaning are related but separate decisions.

---

# 9. Designing an E-Commerce Schema

Now I want to combine the concepts into a realistic design.

An e-commerce application needs users, products, orders, and payments. Each table stores different kinds of information, so each needs suitable types.

## 9.1 Users

```sql
CREATE TABLE users (
    id BIGINT UNSIGNED,
    full_name VARCHAR(150),
    email VARCHAR(254),
    phone_number VARCHAR(20),
    date_of_birth DATE,
    is_verified BOOLEAN,
    created_at DATETIME
);
```

Why these types?

- `BIGINT UNSIGNED` supports a large non-negative numeric identifier.
- `VARCHAR(150)` supports names of varying lengths.
- `VARCHAR(254)` is a possible email-length choice for this example.
- `VARCHAR(20)` stores a phone number as text because phone numbers can contain `+`, leading zeros, spaces, or other formatting characters.
- `DATE` represents the birth date without a time.
- `BOOLEAN` expresses whether the account is verified.
- `DATETIME` records the account creation date and time.

Notice the phone number. Although it contains digits, it is not a quantity that I calculate with. Treating it as text avoids losing meaningful formatting or leading zeros.

## 9.2 Products

```sql
CREATE TABLE products (
    id BIGINT UNSIGNED,
    name VARCHAR(200),
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INT UNSIGNED,
    discount_percent DECIMAL(5,2),
    is_available BOOLEAN,
    attributes JSON,
    created_at DATETIME
);
```

Here:

- The name uses `VARCHAR`.
- The longer description uses `TEXT`.
- The price uses `DECIMAL`.
- The stock quantity uses an unsigned integer.
- The discount uses `DECIMAL`.
- Availability uses a Boolean-style column.
- Flexible product specifications may be stored as JSON.
- The creation time uses `DATETIME`.

The design illustrates the main type families, but a production schema would still need suitable primary keys, constraints, indexes, and business rules.

## 9.3 Orders

```sql
CREATE TABLE orders (
    id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED,
    status VARCHAR(30),
    total_amount DECIMAL(12,2),
    placed_at DATETIME
);
```

The `user_id` column is intended to reference a user.

Using compatible identifier types helps prepare the tables for a foreign-key relationship, which I will study in a later lesson.

`VARCHAR(30)` is a simple choice for order status in this example. In a real application, I would consider whether a fixed set of statuses or a separate status table better fits the business requirements.

## 9.4 Payments

```sql
CREATE TABLE payments (
    id BIGINT UNSIGNED,
    order_id BIGINT UNSIGNED,
    amount DECIMAL(12,2),
    payment_reference VARCHAR(100),
    status VARCHAR(30),
    processed_at DATETIME
);
```

A payment amount uses `DECIMAL` because exact decimal representation is generally appropriate for money.

The payment reference uses text because it is an identifier, not a quantity. Its format may contain letters, digits, and punctuation.

The processing time uses `DATETIME` for this example. A real payment system should deliberately choose its time representation and time-zone strategy.

---

# 10. Important Rules I Want to Carry Forward

Before finishing the lesson, I want to make the most important decisions explicit.

## Numeric types

- Choose integer types according to the expected range.
- Use `UNSIGNED` when negative values genuinely have no meaning and its range is appropriate.
- Use `DECIMAL` for exact decimal values such as financial amounts.
- Use `FLOAT` or `DOUBLE` when approximate floating-point representation is appropriate.
- Remember that a numeric type does not enforce every business rule.

## String types

- Use `VARCHAR` for many ordinary variable-length strings.
- Use `CHAR` for appropriate fixed-length fields.
- Use `TEXT` types for longer text content.
- Recognize `ENUM` and `SET`, but consider whether relational alternatives are more suitable.
- Choose an appropriate character set and collation for the application's language and comparison requirements.

## Date and time types

- Use `DATE` for calendar dates.
- Use `TIME` for time values or intervals.
- Choose between `DATETIME` and `TIMESTAMP` based on time-zone behavior and supported range.
- Do not store a date as arbitrary text when a temporal type better represents the information.

## Other types

- `BOOLEAN` is an alias for `TINYINT(1)` in MySQL.
- Binary types are useful for data represented as bytes.
- `JSON` is useful for appropriate document-shaped data, but it does not replace relational tables.
- `NULL` is a missing or unknown value, not a data type.

---

# 11. How I Will Practise This Lesson

Reading the concepts is only the first step. I need to see what MySQL does when I create tables and query their values.

In `playground.sql`, I will:

1. Create a practice table with representative numeric, string, date/time, Boolean, and JSON columns.
2. Insert sample values.
3. Inspect the table using `DESCRIBE`.
4. Read the stored values using `SELECT`.
5. Compare exact decimal values with approximate floating-point values.
6. Extract a value from a JSON document.
7. Inspect the complete table definition using `SHOW CREATE TABLE`.
8. Experiment with invalid values and observe how MySQL responds under the current SQL mode.

I will run the script in my `sql_learning` database, then compare the results with the explanations in this README.

I should remember that rerunning a script containing `INSERT` statements can add the same sample data again unless the script is designed to be repeatable.

## Lesson Complete

I now understand the major MySQL data type families and, more importantly, why different application values need different representations.

When I build my own backend, I want to think about the meaning of each column before deciding its type.

The next lesson will focus on database commands: creating, selecting, inspecting, and removing databases, with a clear understanding of what each command actually does.