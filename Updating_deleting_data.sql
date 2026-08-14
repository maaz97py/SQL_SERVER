/* =========================================================
   MODULE: Updating & Deleting Data
   Topics:
   - UPDATE
   - DELETE
   - Importance of WHERE
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.Employees;
GO

CREATE TABLE dbo.Employees
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

INSERT INTO dbo.Employees
VALUES
(101, 'Rahul', 'IT', 70000),
(102, 'Priya', 'HR', 50000),
(103, 'Amit', 'Finance', 65000),
(104, 'Neha', 'IT', 75000),
(105, 'Rohan', 'HR', 48000);
GO

-- View original data
SELECT *
FROM dbo.Employees;
GO

-- Update one record
UPDATE dbo.Employees
SET Salary = 75000
WHERE EmployeeID = 101;
GO

-- Verify update
SELECT *
FROM dbo.Employees
WHERE EmployeeID = 101;
GO

-- Update multiple records
UPDATE dbo.Employees
SET Salary = Salary + 5000
WHERE Department = 'IT';
GO

-- Verify
SELECT *
FROM dbo.Employees;
GO

-- Delete one record
DELETE FROM dbo.Employees
WHERE EmployeeID = 105;
GO

-- Verify deletion
SELECT *
FROM dbo.Employees;
GO

-- IMPORTANT:
-- Always use WHERE with UPDATE and DELETE
-- unless you intentionally want to affect every row.