-- Retail Sales & Customer Analytics Project

CREATE DATABASE retail_analytics_p1;
 
-- create table "categories"
CREATE TABLE categories
(
		    CategoryID VARCHAR(15) PRIMARY KEY,
		    CategoryName VARCHAR(25)
);



-- create table "products"
CREATE TABLE products
(	
            ProductID VARCHAR (15) PRIMARY KEY, 
		    ProductName	VARCHAR (50),
		    CategoryID VARCHAR (15)
            FOREIGN KEY (categoryid) REFERENCES categories (categoryid)
);



-- create table "customers"
CREATE TABLE customers
(	
		    CustomerID VARCHAR (15) PRIMARY KEY,
		    Gender VARCHAR (10),	
		    Age	INT,
		    City VARCHAR (15),	
		    Region VARCHAR (25),
		    CustomerSegment	VARCHAR (15),
		    SignUpDate DATE
);



-- create table "orders"
CREATE TABLE orders
(	
		    OrderID VARCHAR (15) PRIMARY KEY, 
		    CustomerID VARCHAR (15),  
		    OrderDate DATE,	
		    OrderTime TIME
            FOREIGN KEY (customerid) REFERENCES customers (customerid)
);



-- create table "order_details"
CREATE TABLE order_details
(	
		    OrderID VARCHAR (15), 
		    ProductID VARCHAR (15), 
		    Quantity INT,	
		    UnitCost NUMERIC, 	
		    UnitPrice NUMERIC,	
		    DiscountRate NUMERIC,	
		    IsReturned INT,	
		    ReturnDate DATE,	
		    ReturnTime TIME,	
		    ReturnReason VARCHAR (50),
		
		    PRIMARY KEY (OrderID, ProductID)
            FOREIGN KEY (orderid) REFERENCES orders (orderid),
            FOREIGN KEY (productid) REFERENCES products (productid)
);

