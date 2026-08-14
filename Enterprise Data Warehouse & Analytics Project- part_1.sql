/* =========================================================
   MODULE: Enterprise Data Warehouse & Analytics Project
   PART 1

   Topics:
   - Database Design
   - Relationships
   - Constraints
   - CRUD Operations
   ========================================================= */

USE master;
GO

IF DB_ID('AnalyticsDB') IS NULL
BEGIN
    CREATE DATABASE AnalyticsDB;
END;
GO

USE AnalyticsDB;
GO

/*
=========================================================
CUSTOMER TABLE
=========================================================
*/

DROP TABLE IF EXISTS dbo.OrderDetails;
DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Products;
DROP TABLE IF EXISTS dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
    CustomerID INT IDENTITY(1,1)
        CONSTRAINT PK_Customers
        PRIMARY KEY,

    CustomerName VARCHAR(100)
        CONSTRAINT CK_Customers_Name
        CHECK (LEN(CustomerName) >= 2),

    Email VARCHAR(150)
        CONSTRAINT UQ_Customers_Email
        UNIQUE,

    City VARCHAR(50)
        CONSTRAINT DF_Customers_City
        DEFAULT 'Bengaluru'
);
GO

/*
=========================================================
PRODUCT TABLE
=========================================================
*/

CREATE TABLE dbo.Products
(
    ProductID INT IDENTITY(1,1)
        CONSTRAINT PK_Products
        PRIMARY KEY,

    ProductName VARCHAR(100) NOT NULL,

    Category VARCHAR(50) NOT NULL,

    Price DECIMAL(10,2)
        CONSTRAINT CK_Products_Price
        CHECK (Price > 0)
);
GO

/*
=========================================================
ORDERS TABLE
=========================================================
*/

CREATE TABLE dbo.Orders
(
    OrderID INT IDENTITY(1,1)
        CONSTRAINT PK_Orders
        PRIMARY KEY,

    CustomerID INT NOT NULL,

    OrderDate DATE
        CONSTRAINT DF_Orders_OrderDate
        DEFAULT GETDATE(),

    OrderStatus VARCHAR(30)
        CONSTRAINT DF_Orders_Status
        DEFAULT 'Pending',

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID)
);
GO

/*
=========================================================
ORDER DETAILS TABLE
=========================================================
*/

CREATE TABLE dbo.OrderDetails
(
    OrderDetailID INT IDENTITY(1,1)
        CONSTRAINT PK_OrderDetails
        PRIMARY KEY,

    OrderID INT NOT NULL,

    ProductID INT NOT NULL,

    Quantity INT
        CONSTRAINT CK_OrderDetails_Quantity
        CHECK (Quantity > 0),

    UnitPrice DECIMAL(10,2)
        CONSTRAINT CK_OrderDetails_UnitPrice
        CHECK (UnitPrice > 0),

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO

/*
=========================================================
CREATE / INSERT
=========================================================
*/

INSERT INTO dbo.Customers
(
    CustomerName,
    Email,
    City
)
VALUES
('Rahul Kumar', 'rahul@gmail.com', 'Delhi'),
('Priya Sharma', 'priya@gmail.com', 'Mumbai'),
('Amit Singh', 'amit@gmail.com', 'Hyderabad'),
('Neha Verma', 'neha@gmail.com', 'Chennai');
GO

INSERT INTO dbo.Products
(
    ProductName,
    Category,
    Price
)
VALUES
('Laptop', 'Electronics', 75000),
('Mouse', 'Accessories', 1200),
('Keyboard', 'Accessories', 2500),
('Monitor', 'Electronics', 18000),
('Headphones', 'Accessories', 5000);
GO

INSERT INTO dbo.Orders
(
    CustomerID,
    OrderDate,
    OrderStatus
)
VALUES
(1, '2026-01-10', 'Completed'),
(2, '2026-01-12', 'Completed'),
(1, '2026-02-05', 'Pending'),
(3, '2026-02-10', 'Completed');
GO

INSERT INTO dbo.OrderDetails
(
    OrderID,
    ProductID,
    Quantity,
    UnitPrice
)
VALUES
(1, 1, 1, 75000),
(1, 2, 2, 1200),
(2, 4, 1, 18000),
(3, 3, 1, 2500),
(4, 5, 2, 5000);
GO

/*
=========================================================
READ
=========================================================
*/

SELECT *
FROM dbo.Customers;
GO

SELECT *
FROM dbo.Products;
GO

SELECT *
FROM dbo.Orders;
GO

SELECT *
FROM dbo.OrderDetails;
GO

/*
=========================================================
UPDATE
=========================================================
*/

UPDATE dbo.Products
SET Price = 1300
WHERE ProductID = 2;
GO

/*
=========================================================
DELETE
=========================================================
*/

-- Delete a customer only if there are no related orders.
-- This demonstrates referential integrity.

-- DELETE FROM dbo.Customers
-- WHERE CustomerID = 4;

GO

/*
=========================================================
RELATIONSHIP QUERY
=========================================================
*/

SELECT
    o.OrderID,
    c.CustomerName,
    o.OrderDate,
    o.OrderStatus
FROM dbo.Orders o
INNER JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID;
GO

/*
=========================================================
ORDER + PRODUCT REPORT
=========================================================
*/

SELECT
    o.OrderID,
    c.CustomerName,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS LineTotal
FROM dbo.Orders o
JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
JOIN dbo.Products p
    ON od.ProductID = p.ProductID;
GO