# L12 - Comparison Operators

## Why Am I Learning This?

Imagine I'm building an e-commerce application.

The application has a `products` table containing hundreds or thousands of products.

Now, suppose I want to:

- Find products that cost more than ₹1,000.
- Find products that cost less than ₹500.
- Find products whose stock is at least 10.
- Find products that are not priced at ₹999.
- Find products whose price is exactly ₹1,499.

I can't solve all these requirements using only equality checks.

I need a way to compare values and filter records based on those comparisons.

That's why I'm learning **Comparison Operators**.

## What Am I Going to Study?

1. What are Comparison Operators?
2. Equal To (`=`)
3. Not Equal To (`!=` and `<>`)
4. Greater Than (`>`)
5. Less Than (`<`)
6. Greater Than or Equal To (`>=`)
7. Less Than or Equal To (`<=`)
8. Combining Comparison Operators with WHERE
9. SQL Comparison Operators vs MongoDB
10. Real-world backend applications

## 1. What Are Comparison Operators?

Comparison operators allow me to compare two values and determine whether a particular condition is true.

They are commonly used with the `WHERE` clause to filter records.

For example:

```sql
SELECT *
FROM products
WHERE price > 1000;
```

This query retrieves only those products whose price is greater than 1000.

MySQL evaluates the condition for each record and returns the matching rows.

## 2. Understanding Our Example Table

Before using these operators, let's imagine our e-commerce application has the following `products` table.

| product_id | product_name | category | price | stock |
|---|---|---|---:|---:|
| 101 | Keyboard | Accessories | 799 | 15 |
| 102 | Mouse | Accessories | 499 | 25 |
| 103 | Monitor | Electronics | 8999 | 8 |
| 104 | Headphones | Electronics | 1499 | 12 |
| 105 | USB Cable | Accessories | 199 | 50 |
| 106 | Webcam | Electronics | 2499 | 5 |

I'll use these records to understand each operator.

## 3. Equal To (`=`)

### Why do I need it?

Sometimes I want to retrieve products that have an exact value.

For example, suppose I want to find a product whose price is exactly ₹1,499.

The equal-to operator (`=`) checks whether two values are equal.

### SQL Example

```sql
SELECT *
FROM products
WHERE price = 1499;
```

**What is MySQL doing?**

It checks the price of every product.

If the price is exactly 1499, that product is included in the result.

**Expected Output:**

| product_id | product_name | category | price | stock |
|---|---|---|---:|---:|
| 104 | Headphones | Electronics | 1499 | 12 |

I can also use equality to compare text values:

```sql
SELECT *
FROM products
WHERE category = 'Electronics';
```

This retrieves products belonging to the Electronics category.

Remember:
- Use single quotes for text values.
- Numeric values don't require quotation marks.

## 4. Not Equal To (`!=` and `<>`)

### Why do I need it?

Suppose I want to find every product except the Mouse.

I don't want to manually specify all the other product names.

I simply need to exclude records that match a particular value.

That's where the not-equal operators come in.

MySQL supports two ways to write not equal:

- `!=`
- `<>`

Both mean the same thing.

### SQL Example

```sql
SELECT *
FROM products
WHERE product_name != 'Mouse';
```

**Expected Output:**

All products except Mouse.

I can write the same query using `<>`:

```sql
SELECT *
FROM products
WHERE product_name <> 'Mouse';
```

Both queries produce the same result.

**Remember:** `!=` and `<>` are interchangeable in MySQL. You'll commonly see both in SQL code.

## 5. Greater Than (`>`)

### Why do I need it?

Imagine the store wants to display all products costing more than ₹1,000.

The greater-than operator (`>`) checks whether the left value is strictly greater than the right value.

### SQL Example

```sql
SELECT *
FROM products
WHERE price > 1000;
```

**Expected Output:**

| product_name | price |
|---|---:|
| Monitor | 8999 |
| Headphones | 1499 |
| Webcam | 2499 |

Notice that the Keyboard costs ₹799, so it isn't included.

Also, a product costing exactly ₹1,000 would not be included because `>` means strictly greater than.

## 6. Less Than (`<`)

### Why do I need it?

Now suppose the store wants to display budget-friendly products costing less than ₹500.

The less-than operator (`<`) checks whether the left value is strictly smaller than the right value.

### SQL Example

```sql
SELECT *
FROM products
WHERE price < 500;
```

**Expected Output:**

| product_name | price |
|---|---:|
| Mouse | 499 |
| USB Cable | 199 |

A product costing exactly ₹500 would not be included.

## 7. Greater Than or Equal To (`>=`)

### Why do I need it?

Suppose I want to find products whose stock is at least 10.

That means I want products with stock equal to 10 as well as products with stock greater than 10.

Using only `>` would exclude products having exactly 10 units.

That's why we use `>=`.

### SQL Example

```sql
SELECT *
FROM products
WHERE stock >= 10;
```

**Expected Output:**

| product_name | stock |
|---|---:|
| Keyboard | 15 |
| Mouse | 25 |
| Headphones | 12 |
| USB Cable | 50 |

The operator includes the boundary value.

## 8. Less Than or Equal To (`<=`)

### Why do I need it?

Imagine the store wants to identify products that have 8 or fewer units remaining.

I need to include products with exactly 8 units as well as products with fewer than 8.

That's where `<=` helps.

### SQL Example

```sql
SELECT *
FROM products
WHERE stock <= 8;
```

**Expected Output:**

| product_name | stock |
|---|---:|
| Monitor | 8 |
| Webcam | 5 |

The product with exactly 8 units is also included.

## 9. Understanding All Comparison Operators Together

Let's quickly compare all the operators.

| Operator | Meaning | Example |
|---|---|---|
| `=` | Equal to | `price = 999` |
| `!=` | Not equal to | `price != 999` |
| `<>` | Not equal to | `price <> 999` |
| `>` | Greater than | `price > 1000` |
| `<` | Less than | `price < 500` |
| `>=` | Greater than or equal to | `stock >= 10` |
| `<=` | Less than or equal to | `stock <= 8` |

### Important Difference: `>` vs `>=`

This is something I should clearly understand.

Suppose the product price is ₹1,000.

| Condition | Result |
|---|---|
| `price > 1000` | FALSE |
| `price >= 1000` | TRUE |
| `price < 1000` | FALSE |
| `price <= 1000` | TRUE |

The difference is whether the boundary value is included.

- `>` and `<` exclude the boundary value.
- `>=` and `<=` include the boundary value.

## 10. Combining Comparison Operators with Logical Operators

I've already learned logical operators in L11.

Now I can combine both concepts to create more useful queries.

For example, suppose I want to find products that cost more than ₹1,000 and have at least 10 units in stock.

```sql
SELECT *
FROM products
WHERE price > 1000
AND stock >= 10;
```

**Expected Output:**

| product_name | price | stock |
|---|---:|---:|
| Headphones | 1499 | 12 |

Another example: find products that cost less than ₹500 or have stock greater than 20.

```sql
SELECT *
FROM products
WHERE price < 500
OR stock > 20;
```

This combines what I learned in L11 with the comparison operators from this lesson.

## 11. SQL Comparison Operators vs MongoDB

Since I've already worked with MongoDB, I can connect these concepts to its query operators.

MongoDB uses operators such as `$gt`, `$lt`, `$gte`, `$lte`, and `$ne`.

Let's compare them.

### Greater Than

**SQL:**

```sql
SELECT *
FROM products
WHERE price > 1000;
```

**MongoDB:**

```javascript
db.products.find({
  price: { $gt: 1000 }
});
```

### Less Than

**SQL:**

```sql
SELECT *
FROM products
WHERE price < 500;
```

**MongoDB:**

```javascript
db.products.find({
  price: { $lt: 500 }
});
```

### Greater Than or Equal To

**SQL:**

```sql
SELECT *
FROM products
WHERE stock >= 10;
```

**MongoDB:**

```javascript
db.products.find({
  stock: { $gte: 10 }
});
```

### Less Than or Equal To

**SQL:**

```sql
SELECT *
FROM products
WHERE stock <= 8;
```

**MongoDB:**

```javascript
db.products.find({
  stock: { $lte: 8 }
});
```

### Not Equal To

**SQL:**

```sql
SELECT *
FROM products
WHERE price != 999;
```

**MongoDB:**

```javascript
db.products.find({
  price: { $ne: 999 }
});
```

The mental model is similar: both databases allow me to retrieve records by comparing field values.

The syntax is different because SQL uses comparison operators directly, while MongoDB uses query operators such as `$gt` and `$ne`.

## 12. How Will I Use This in Backend Development?

Imagine I'm building an e-commerce backend using Node.js, Express, and MySQL.

A customer wants to see products costing less than ₹1,000.

My backend can execute a query like this:

```sql
SELECT *
FROM products
WHERE price < 1000;
```

Similarly, I can build features such as:

- Display products within a price requirement.
- Find products with low inventory.
- Identify expensive products.
- Find orders above a particular amount.
- Retrieve users based on their age.

For example, an inventory management API could use:

```sql
SELECT *
FROM products
WHERE stock <= 8;
```

This helps the application identify products that may need restocking.

The important idea is that comparison operators turn ordinary database queries into useful business logic.

## Quick Revision

- Comparison operators compare values.
- `=` checks equality.
- `!=` and `<>` check inequality.
- `>` and `<` perform strict comparisons.
- `>=` and `<=` include the boundary value.
- Comparison operators are commonly used with `WHERE`.
- They can also be combined with logical operators such as `AND` and `OR`.

## What Should I Be Able to Explain After This Lesson?

After completing this lesson, I should be able to explain:

1. What are comparison operators?
2. What is the difference between `=` and `!=`?
3. Why does MySQL support both `!=` and `<>`?
4. What is the difference between `>` and `>=`?
5. What is the difference between `<` and `<=`?
6. How can I combine comparison operators with logical operators?
7. How do SQL comparison operators compare with MongoDB operators?

## What's Next?

In the next lesson, I'll learn **L13 - ORDER BY (Sorting Data)**.

So far, I've learned how to retrieve records based on conditions.

But what if I want to display products from the lowest price to the highest price? Or arrange products from highest stock to lowest stock?

That's where `ORDER BY` comes in.

I'll learn how to sort query results in ascending and descending order using `ASC` and `DESC`.