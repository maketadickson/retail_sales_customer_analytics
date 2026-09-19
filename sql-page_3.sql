SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM products; 



-- Data Expolration & Quality Checks

-- Checking row counts

SELECT	COUNT (*) 
FROM 	categories;

SELECT	COUNT (*) 
FROM 	customers;

SELECT	COUNT (*) 
FROM 	order_details;

SELECT	COUNT (*) 
FROM 	orders;

SELECT	COUNT (*) 
FROM 	products;


-- Checking for NULL values

SELECT * FROM categories
WHERE 
	categoryid IS NULL 
	OR
	categoryname IS NULL;


SELECT * FROM customers 
WHERE
	customerid IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	city IS NULL
	OR
	region IS NULL
	OR
	customersegment IS NULL
	OR
	signupdate IS NULL;


SELECT * FROM order_details
WHERE 
	orderid IS NULL
	OR
	productid IS NULL
	OR
	quantity IS NULL
	OR
	unitcost IS NULL
	OR
	unitprice IS NULL
	OR
	discountrate IS NULL
	OR 
	isreturned IS NULL
	OR
	returndate IS NULL
	OR 
	returntime IS NULL
	OR
	returnreason IS NULL;


SELECT * FROM orders
WHERE 
	orderid IS NULL
	OR
	customerid IS NULL
	OR
	orderdate IS NULL
	OR
	ordertime IS NULL;


SELECT * FROM products
WHERE
	productid IS NULL
	OR
	productname IS NULL
	OR
	categoryid IS NULL;


-- Checking for duplicates 

SELECT categoryid,
	COUNT(*)
FROM categories
GROUP BY categoryid
HAVING COUNT (*) > 1;


SELECT customerid,
	COUNT(*)
FROM customers
GROUP BY customerid
HAVING COUNT (*) > 1;


SELECT orderid, productid,
	COUNT(*)
FROM order_details
GROUP BY orderid, productid
HAVING COUNT (*) > 1;


SELECT orderid,
	COUNT(*)
FROM orders
GROUP BY orderid
HAVING COUNT (*) > 1;


SELECT productid,
	COUNT(*)
FROM products
GROUP BY productid
HAVING COUNT (*) > 1;


-- Checking for invalid date values

SELECT
	MIN(signupdate) as earliest_date,
	MAX(signupdate) as latest_date
FROM customers;


SELECT
	MIN(returndate) as earliest_date,
	MAX(returndate) as latest_date 
FROM order_details;


SELECT
	MIN(orderdate),
	MAX(orderdate)
FROM orders;


-- Checking for invalid time values

SELECT 
	MIN(returntime) as shortest_time,
	MAX(returntime) as longest_time
FROM order_details; 



-- Data Cleaning

SELECT
	returndate,
	isreturned,
	COUNT(*) as records
	FROM order_details
	GROUP BY 1, 2
	ORDER BY 1 DESC;

SELECT * 
FROM order_details
WHERE 
	returndate = '9999-12-31'
	AND 
	returntime = '00:00:00'
LIMIT 20;

UPDATE order_details
SET returndate = 	NULL 
WHERE 
	returndate = '9999-12-31'
	AND
	isreturned = 0;

SELECT 
	returntime,
	isreturned,
	COUNT(*) as records
	FROM order_details
	GROUP BY 1, 2
	ORDER BY 1 ASC;

SELECT *
FROM order_details
WHERE
	returntime = '00:00:00'
	AND
	isreturned = 0
	LIMIT 20;

UPDATE order_details
SET returntime = NULL 
WHERE 
	returntime = '00:00:00'
	AND
	isreturned = 0



-- Data Validation

SELECT COUNT (*)
FROM order_details
WHERE returndate = '9999-12-31';

SELECT COUNT (*)
FROM order_details
WHERE returntime = '00:00:00';

SELECT COUNT (*)
FROM order_details
WHERE isreturned = 0
	AND 
	returndate IS NOT NULL;

SELECT COUNT (*)
FROM order_details
WHERE 
	isreturned = 0
	AND 
	returntime IS NOT NULL;

