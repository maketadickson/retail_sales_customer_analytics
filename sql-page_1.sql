-- Retail Sales & Customer Analytics Project

-- creating tables

CREATE TABLE categories
	(
		CategoryID VARCHAR(15) PRIMARY KEY,
		CategoryName VARCHAR(25)
	);

CREATE TABLE products
	(	
		ProductID VARCHAR (15) PRIMARY KEY, 
		ProductName	VARCHAR (50),
		CategoryID VARCHAR (15) -- FK
	);

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

CREATE TABLE orders
	(	
		OrderID VARCHAR (15) PRIMARY KEY, 
		CustomerID VARCHAR (15), -- FK 
		OrderDate DATE,	
		OrderTime TIME
	);

CREATE TABLE order_details
	(	
		OrderID VARCHAR (15), -- FK
		ProductID VARCHAR (15), -- FK
		Quantity INT,	
		UnitCost NUMERIC, 	
		UnitPrice NUMERIC,	
		DiscountRate NUMERIC,	
		IsReturned INT,	
		ReturnDate DATE,	
		ReturnTime TIME,	
		ReturnReason VARCHAR (50),
		
		PRIMARY KEY (OrderID, ProductID)
	);


-- FOREIGN KEY

ALTER TABLE products
ADD CONSTRAINT fk_categories
FOREIGN KEY (CategoryID)
REFERENCES categories (CategoryID);

ALTER TABLE orders
ADD CONSTRAINT fk_customers
FOREIGN KEY (CustomerID)
REFERENCES customers (CustomerID);

ALTER TABLE order_details
ADD CONSTRAINT fk_orders
FOREIGN KEY (OrderID)
REFERENCES orders (OrderID);

ALTER TABLE order_details
ADD CONSTRAINT fk_products
FOREIGN KEY (ProductID)
REFERENCES products (ProductID);





	