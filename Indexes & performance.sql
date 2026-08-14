/* =========================================================
   MODULE: Indexes & Performance
   Topics:
   - Clustered Indexes
   - Non-Clustered Indexes
   - Query Performance
   - Execution Plan / EXPLAIN Equivalent
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.EmployeePerformance;
GO

CREATE TABLE dbo.EmployeePerformance
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary INT
);
GO

/*
PRIMARY KEY creates a clustered index by default
unless another clustered index has been explicitly defined.
*/

-- Generate 20,000 records
;WITH Numbers AS
(
    SELECT TOP (20000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Num
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO dbo.EmployeePerformance
(
    EmployeeID,
    EmployeeName,
    Department,
    Salary
)
SELECT
    Num,
    'Employee' + CAST(Num AS VARCHAR(10)),
    CASE
        WHEN Num % 4 = 0 THEN 'IT'
        WHEN Num % 4 = 1 THEN 'HR'
        WHEN Num % 4 = 2 THEN 'Finance'
        ELSE 'Sales'
    END,
    30000 + (Num % 50000)
FROM Numbers;
GO

-- Check indexes
SELECT
    name AS IndexName,
    type_desc AS IndexType
FROM sys.indexes
WHERE object_id = OBJECT_ID('dbo.EmployeePerformance');
GO

/*
=========================================================
QUERY WITHOUT INDEX ON SALARY
=========================================================
*/

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT *
FROM dbo.EmployeePerformance
WHERE Salary = 45000;
GO

/*
In SSMS:
Query -> Include Actual Execution Plan
Shortcut: Ctrl + M

Look for:
- Table Scan
- Clustered Index Scan
=========================================================
*/

-- Create Non-Clustered Index
CREATE NONCLUSTERED INDEX IX_EmployeePerformance_Salary
ON dbo.EmployeePerformance(Salary);
GO

/*
=========================================================
RUN THE SAME QUERY AGAIN
=========================================================
*/

SELECT *
FROM dbo.EmployeePerformance
WHERE Salary = 45000;
GO

/*
Now inspect the Execution Plan.

You may see:
Index Seek

This demonstrates the benefit of the index.
*/

-- Clustered Index lookup
SELECT *
FROM dbo.EmployeePerformance
WHERE EmployeeID = 10000;
GO

/*
EmployeeID is the Primary Key.
Therefore SQL Server normally uses the
Clustered Index for this lookup.
*/

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

/*
=========================================================
SQL SERVER EXPLAIN-LIKE DEMONSTRATION
=========================================================

SQL Server does not use:

EXPLAIN SELECT ...

Instead, use the Execution Plan.

Estimated Plan:
Query -> Display Estimated Execution Plan
Shortcut: Ctrl + L

Actual Plan:
Query -> Include Actual Execution Plan
Shortcut: Ctrl + M

You can also use SHOWPLAN_ALL:
*/

SET SHOWPLAN_ALL ON;
GO

SELECT *
FROM dbo.EmployeePerformance
WHERE Salary = 45000;
GO

SET SHOWPLAN_ALL OFF;
GO