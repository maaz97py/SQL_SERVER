/* =========================================================
   MODULE: Enterprise Data Warehouse & Analytics Project
   PART 2

   Topics:
   - Analytical Queries
   - Reports
   - Aggregations
   - Customer Analysis
   - Product Analysis
   - Sales Analysis
   ========================================================= */

USE AnalyticsDB;
GO

/*
=========================================================
1. COMPLETE SALES REPORT
=========================================================
*/

SELECT
    o.OrderID,
    c.CustomerName,
    c.City,
    o.OrderDate,
    o.OrderStatus,
    p.ProductName,
    p.Category,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS TotalAmount
FROM dbo.Orders o
JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
JOIN dbo.Products p
    ON od.ProductID = p.ProductID
ORDER BY o.OrderDate DESC;
GO

/*
=========================================================
2. TOTAL SALES
=========================================================
*/

SELECT
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM dbo.OrderDetails od;
GO

/*
=========================================================
3. SALES BY CUSTOMER
=========================================================
*/

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM dbo.Customers c
JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalSpent DESC;
GO

/*
=========================================================
4. SALES BY PRODUCT
=========================================================
*/

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM dbo.Products p
JOIN dbo.OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalRevenue DESC;
GO

/*
=========================================================
5. SALES BY CATEGORY
=========================================================
*/

SELECT
    p.Category,
    SUM(od.Quantity * od.UnitPrice) AS CategoryRevenue
FROM dbo.Products p
JOIN dbo.OrderDetails od
    ON p.ProductID = od.ProductID
GROUP BY p.Category
ORDER BY CategoryRevenue DESC;
GO

/*
=========================================================
6. ORDERS BY STATUS
=========================================================
*/

SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders
FROM dbo.Orders
GROUP BY OrderStatus;
GO

/*
=========================================================
7. CUSTOMERS WITH NO ORDERS
=========================================================
*/

SELECT
    c.CustomerID,
    c.CustomerName,
    c.City
FROM dbo.Customers c
LEFT JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
GO

/*
=========================================================
8. TOP CUSTOMERS
=========================================================
*/

SELECT TOP 3
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM dbo.Customers c
JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;
GO

/*
=========================================================
9. MONTHLY SALES REPORT
=========================================================
*/

SELECT
    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,
    SUM(od.Quantity * od.UnitPrice) AS MonthlySales
FROM dbo.Orders o
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY
    OrderYear,
    OrderMonth;
GO

/*
=========================================================
10. AVERAGE ORDER VALUE
=========================================================
*/

SELECT
    AVG(OrderTotal) AS AverageOrderValue
FROM
(
    SELECT
        o.OrderID,
        SUM(od.Quantity * od.UnitPrice) AS OrderTotal
    FROM dbo.Orders o
    JOIN dbo.OrderDetails od
        ON o.OrderID = od.OrderID
    GROUP BY o.OrderID
) AS OrderSummary;
GO

/*
=========================================================
11. HIGH-VALUE ORDERS
=========================================================
*/

SELECT
    o.OrderID,
    c.CustomerName,
    SUM(od.Quantity * od.UnitPrice) AS OrderValue
FROM dbo.Orders o
JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID,
    c.CustomerName
HAVING SUM(od.Quantity * od.UnitPrice) > 10000
ORDER BY OrderValue DESC;
GO

/*
=========================================================
12. FINAL BUSINESS REPORT
=========================================================
*/

SELECT
    c.CustomerName,
    c.City,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.Quantity) AS ItemsPurchased,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
    AVG(od.UnitPrice) AS AverageUnitPrice
FROM dbo.Customers c
LEFT JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN dbo.OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY
    c.CustomerName,
    c.City
ORDER BY TotalSpent DESC;
GO