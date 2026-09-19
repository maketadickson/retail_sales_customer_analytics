-- SQL-based business analysis

/* Task 1: What are the different customer segments in the customers table, 
and how many customers belong to each segment?
*/

SELECT 
	customersegment,
	COUNT (*) as customer_count
FROM customers
GROUP BY 1
ORDER BY 2 DESC;


--  Task 2: Find all customers whose city contains the word "stan".

SELECT * 
FROM customers
WHERE city ILIKE '%stan%';


-- Task 3: Which cities have more than one customer?

SELECT
	city,
	COUNT (*) as customer_count
FROM customers
GROUP BY 1
HAVING COUNT (*) > 1
ORDER BY 2 DESC;


-- Task 4: How many products are there in each product category?

SELECT 
	categoryid,
	COUNT(*) as product_count
FROM products
GROUP BY 1
ORDER BY 2 DESC;


-- Task 5: What are the minimum, maximum, and average product prices?

SELECT 
	MIN(unitprice) as minimum_price,
	MAX(unitprice) as maximum_price,
	ROUND(AVG(unitprice), 2) as avg_price
FROM order_details;


-- Task 6: Which products have a price greater than 10?

SELECT productid
FROM order_details
WHERE unitprice > 10;


-- Task 7: How many orders were placed on each order date?

SELECT 
	orderdate,
	COUNT(*) as total_orders
FROM orders
GROUP BY 1
ORDER BY 1;


-- Task 8: What is the earliest and latest order date in the dataset?

SELECT 
	MIN(orderdate) as earliest_date,
	MAX(orderdate) as latest_date
FROM orders;


-- Task 9: What are the minimum, maximum, and average quantities ordered?

SELECT 
	MIN(quantity) as min_qty_ordered,
	MAX(quantity) as max_qty_ordered,
	ROUND(AVG(quantity), 2) as avg_qty_orderd
FROM order_details;


-- Task 10: How many order-detail records are marked as returned versus not returned?

SELECT 
	isreturned,
	COUNT(*) as record_count
FROM order_details
GROUP BY 1
ORDER BY 1;


-- Task 11: List each product together with its category name.

SELECT 
	p.productid,
	p.productname,
	c.categoryname
FROM products as p
JOIN categories as c
ON c.categoryid = p.categoryid;


/*Task 12: For each order, show the order ID, customer ID, city, region, 
and customer segment.
*/

SELECT 
	o.orderid,
	o.customerid,
	cs.city,
	cs.region,
	cs.customersegment
FROM orders as o
JOIN customers as cs
ON o.customerid = cs.customerid;


-- Task 13: For each product, show its product name, category name, and the total quantity sold.
SELECT 
	p.productid,
	p.productname,
	c.categoryname,
	SUM(od.quantity) as total_quantiy
FROM products as p
JOIN categories as c
ON p.categoryid = c.categoryid
JOIN order_details as od
ON p.productid = od.productid
GROUP BY 1, 2, 3;


-- Task 14: List all customers and show the number of orders each customer has placed.

SELECT 
	cs.customerid,
	cs.city,
	cs.region,
	cs.customersegment,
	COUNT(o.orderid) as total_orders
FROM customers as cs
LEFT JOIN orders as o
ON cs.customerid = o.customerid
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;


-- Task 15: Which products have a price higher than the average price of all products?

SELECT DISTINCT
	p.productid,
	p.productname,
	od.unitprice
FROM products as p
JOIN order_details as od
ON p.productid = od.productid
WHERE od.unitprice > (SELECT AVG(unitprice) FROM order_details)
ORDER BY 3 DESC;	


/* Task 16: Which cities have more than one customer who signed up 
within the last 180 days of the latest signup date?
*/

SELECT 
	city,
	COUNT(customerid) as total_customers
FROM customers
	WHERE signupdate >= (SELECT MAX(signupdate) - INTERVAL '180 days' FROM customers)
GROUP BY 1
HAVING COUNT (customerid) > 1
ORDER BY 2 DESC;
	

-- Task 17: How many orders were placed in each year?

SELECT 
	EXTRACT (YEAR FROM orderdate) as order_year,
	COUNT (*) as total_orders
FROM orders
GROUP BY 1
ORDER BY 1;
	

-- Task 18: Rank products from highest to lowest based on the total quantity sold.

SELECT 
	p.productid,
	p.productname,
	SUM(od.quantity) as total_quantity_sold,
	RANK() OVER (ORDER BY SUM(od.quantity) DESC) as rank
FROM products as p
JOIN order_details as od
ON p.productid = od.productid
GROUP BY 1, 2
ORDER BY rank;


-- Task 19: Which customers have placed more than five orders?

WITH customer_orders
AS
(
SELECT 
	cs.customerid,
	cs.city,
	cs.region,
	cs.customersegment,
	COUNT(o.orderid) as order_count
	FROM customers as cs
	JOIN orders as o
	ON cs.customerid = o.customerid
GROUP BY 1, 2, 3, 4
)
SELECT 
	customerid,
	city,
	region,
	customersegment,
	order_count
FROM customer_orders
WHERE order_count > 5;


-- Task 20: Using a subquery, identify customers who are from Aegean and have placed more than five orders .

SELECT 
	customerid, 
	region, 
	COUNT(orderid) as total_orders
FROM (
	SELECT 
		cs.customerid,
		cs.region, 
		o.orderid
    FROM customers as cs
    JOIN orders as o
        ON cs.customerid = o.customerid
) AS customer_orders
WHERE region = 'Aegean'
GROUP BY 
	customerid,
	region
HAVING COUNT(orderid) > 5
ORDER BY total_orders DESC;

