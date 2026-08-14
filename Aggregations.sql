/* =========================================================
   MODULE: Aggregations
   Topics:
   - COUNT
   - SUM
   - AVG
   - MIN
   - MAX
   - GROUP BY
   - HAVING
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
(103, 'Amit', 'IT', 65000),
(104, 'Neha', 'Finance', 75000),
(105, 'Rohan', 'HR', 48000),
(106, 'Anjali', 'Finance', 72000),
(107, 'Vikram', 'IT', 85000),
(108, 'Sneha', 'HR', 52000);
GO

-- COUNT
SELECT COUNT(*) AS TotalEmployees
FROM dbo.Employees;
GO

-- SUM
SELECT SUM(Salary) AS TotalSalary
FROM dbo.Employees;
GO

-- AVG
SELECT AVG(Salary) AS AverageSalary
FROM dbo.Employees;
GO

-- MIN
SELECT MIN(Salary) AS MinimumSalary
FROM dbo.Employees;
GO

-- MAX
SELECT MAX(Salary) AS MaximumSalary
FROM dbo.Employees;
GO

-- GROUP BY + COUNT
SELECT
    Department,
    COUNT(*) AS EmployeeCount
FROM dbo.Employees
GROUP BY Department;
GO

-- GROUP BY + SUM
SELECT
    Department,
    SUM(Salary) AS TotalSalary
FROM dbo.Employees
GROUP BY Department;
GO

-- GROUP BY + AVG
SELECT
    Department,
    AVG(Salary) AS AverageSalary
FROM dbo.Employees
GROUP BY Department;
GO

-- HAVING
SELECT
    Department,
    COUNT(*) AS EmployeeCount
FROM dbo.Employees
GROUP BY Department
HAVING COUNT(*) > 2;
GO

-- HAVING with AVG
SELECT
    Department,
    AVG(Salary) AS AverageSalary
FROM dbo.Employees
GROUP BY Department
HAVING AVG(Salary) > 60000;
GO

-- GROUP BY + HAVING + ORDER BY
SELECT
    Department,
    AVG(Salary) AS AverageSalary
FROM dbo.Employees
GROUP BY Department
HAVING AVG(Salary) > 50000
ORDER BY AverageSalary DESC;
GO