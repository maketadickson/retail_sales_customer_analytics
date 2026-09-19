# Retail Sales & Customer Analytics with PostgreSQL

##  Project Overview  **Project Title:** Retail Sales & Customer Analytics

**Database:** retail_analytics_p1

This project demonstrates the Retail Sales and Customer Analytics using SQL. It includes relational database design, data exploration, data quality checks, data cleaning, and SQL-based business analysis. The goal is to showcase skills in database design, manipulation, and querying.

![Project Cover](file_000000004d3c820e83f8260a70f1287d.png)

## Objectives

1. Create and structure the PostgreSQL database: Design the tables, Define the appropiate data types, primary keys, and foreign key relationships.
2. Data Exploration & Quality checks: Explore the data and inspect the data quality to see if there is any data to clean.
3. Data Cleaning: Perform a detailed data cleaning for any data quality issue found.
4. Validate the database and cleaned data: Verify the relationships, data consistency, and the results of the cleaning process.
5. Perform SQL-based business analysis: Use queries, joins, aggregations, subqueries, CTEs, and window functions to answer business questions and generate insights.

## Project Structure

### 1.Database Setup

![Database ERD](https://github.com/maketadickson/retail_sales_customer_analytics/blob/main/sql-page_2.PNG)

| Table | Purpose |
|---|---|
| `customers` | Customer demographic and segmentation information |
| `orders` | Order-level information |
| `order_details` | Product-level details for each order |
| `products` | Product information |
| `categories` | Product category information |

### Main columns

**Customers:** `customerid`, `gender`, `age`, `city`, `region`, `customersegment`, `signupdate`

**Orders:** `orderid`, `customerid`, `orderdate`, `ordertime`

**Order Details:** `orderid`, `productid`, `quantity`, `unitcost`, `unitprice`, `discountrate`, `isreturned`, `returndate`, `returntime`, `returnreason`

**Products:** `productid`, `productname`, `categoryid`

**Categories:** `categoryid`, `categoryname`

## 🏗️ Database Design

The database contains five related tables.

Relationships:

- `categories` → `products`
- `products` → `order_details`
- `customers` → `orders`
- `orders` → `order_details`
- `products` → `order_details`

Primary and foreign keys were defined during table creation. `products.categoryid` references `categories.categoryid`, `orders.customerid` references `customers.customerid`, and `order_details` references both `orders` and `products`. fileciteturn1file1L54-L74

### ERD

![Database ERD](images/database-schema.png)

> Export the pgAdmin ERD as a PNG and save it as `images/database-schema.png` so it displays directly on GitHub.

## 🛠️ Technologies

- PostgreSQL
- SQL
- pgAdmin
- Git
- GitHub

## 🔍 Data Profiling & Quality Checks

The project includes row-count checks, NULL checks, duplicate checks, and date/time validation. fileciteturn1file0L11-L25 fileciteturn1file0L29-L95

Duplicate checks were performed across the five tables using grouping and `HAVING COUNT(*) > 1`. fileciteturn1file0L98-L132

Minimum and maximum dates/times were also inspected to identify unusual values. fileciteturn1file0L135-L160

## 🧹 Data Cleaning

The profiling identified `9999-12-31` as a placeholder value for `returndate` on non-returned records. The cleaning process replaced it with `NULL` when `isreturned = 0`.

Likewise, `00:00:00` was treated as a placeholder `returntime` for non-returned records and replaced with `NULL`. fileciteturn1file0L164-L210

This makes the data more semantically meaningful:

- Returned item → actual return date/time where available
- Not returned → `NULL` return date/time

## ✅ Data Validation

After cleaning, validation queries check that:

- `9999-12-31` no longer remains
- `00:00:00` no longer remains
- Non-returned records do not retain a return date
- Non-returned records do not retain a return time fileciteturn1file0L214-L235

## ❓ Business Questions & SQL Analysis

### Customer Analysis

1. What are the different customer segments and how many customers belong to each?
2. Which customers have a city containing the word `"stan"`?
3. Which cities have more than one customer?
4. How many products are there in each product category?

These questions demonstrate filtering, aggregation, `GROUP BY`, and `HAVING`. fileciteturn1file2L3-L41

### Product Analysis

5. What are the minimum, maximum, and average recorded unit prices?
6. Which products have a price greater than 10?
11. Which products belong to each category?
13. What is the total quantity sold for each product?
15. Which products have a price higher than the average recorded unit price?
18. How can products be ranked from highest to lowest based on total quantity sold?

The analysis uses aggregation, joins, a subquery, and the `RANK()` window function. fileciteturn1file2L43-L56 fileciteturn1file2L96-L104 fileciteturn1file2L122-L133 fileciteturn1file2L151-L161 fileciteturn1file2L189-L200

### Order Analysis

7. How many orders were placed on each order date?
8. What is the earliest and latest order date?
17. How many orders were placed in each year?

These demonstrate aggregation, date functions, and `EXTRACT(YEAR FROM orderdate)`. fileciteturn1file2L59-L74 fileciteturn1file2L179-L187

### Customer & Order Behavior

12. For each order, what are the customer ID, city, region, and customer segment?
14. How many orders has each customer placed?
16. Which cities have more than one customer who signed up within 180 days of the latest signup date?
19. Which customers have placed more than five orders?
20. Which customers are from the Aegean region and have placed more than five orders?

These questions demonstrate joins, `LEFT JOIN`, subqueries, CTEs, date intervals, grouping, and `HAVING`. fileciteturn1file2L107-L120 fileciteturn1file2L136-L175 fileciteturn1file2L203-L249

## 🔎 SQL Techniques Demonstrated

| Technique | Example use |
|---|---|
| `WHERE` / `ILIKE` | Filtering records and text search |
| `COUNT()` | Counting customers, products, and orders |
| `MIN()` / `MAX()` | Dates, prices, and quantities |
| `AVG()` | Average price and quantity |
| `GROUP BY` | Aggregating by customer, city, category, and date |
| `HAVING` | Filtering grouped results |
| `INNER JOIN` | Combining related tables |
| `LEFT JOIN` | Keeping all customers while counting orders |
| Subqueries | Average price and signup-date analysis |
| CTE | Customer order-count analysis |
| `EXTRACT()` | Orders by year |
| `RANK()` | Product ranking |
| `UPDATE` | Data cleaning |

## 📊 Key Findings

The uploaded SQL files contain the analysis queries but not the resulting output values. Therefore, numerical findings should be added here only after running the final queries.

- **Customer insight:** `[Add finding]`
- **Product insight:** `[Add finding]`
- **Order insight:** `[Add finding]`
- **Return insight:** `[Add finding]`
- **Regional/customer insight:** `[Add finding]`

## 💡 Business Insights

Add business interpretations supported by your actual query results.

For example:

- Which customer segments have the largest populations?
- Which products have the highest quantities sold?
- Which customers have unusually high order frequency?
- What patterns appear in returns?
- Which regions or cities show higher customer activity?

Replace these prompts with conclusions supported by the actual SQL output.

## 📁 Suggested GitHub Project Structure

```text
retail-sales-customer-analytics/
│
├── README.md
│
├── data/
│   └── raw/
│       ├── customers.csv
│       ├── orders.csv
│       ├── order_details.csv
│       ├── products.csv
│       └── categories.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_profiling_cleaning_validation.sql
│   └── 03_data_analysis.sql
│
├── images/
│   ├── project-cover.png
│   └── database-schema.png
│
└── erd/
    └── retail_database.pgerd
```

## 📝 Conclusion

This project demonstrates an end-to-end PostgreSQL workflow from relational database design through data-quality investigation, cleaning, validation, and business-oriented SQL analysis.

## 📫 Contact

**Name:** Your Name  
**Email:** your.email@example.com  
**Phone:** +255 XXX XXX XXX

Replace these placeholders with your actual details before publishing.

## 👤 Author

**Your Name**

[GitHub Profile](https://github.com/yourusername)
