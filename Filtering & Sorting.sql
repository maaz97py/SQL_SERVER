/* =========================================================
   MODULE: Filtering & Sorting
   Topics:
   - WHERE
   - Comparison Operators
   - ORDER BY
   - Filtering Dates
   - Filtering Text
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
    Salary DECIMAL(10,2),
    HireDate DATE
);
GO

INSERT INTO dbo.Employees
VALUES
(101, 'Rahul', 'IT', 70000, '2022-01-15'),
(102, 'Priya', 'HR', 50000, '2021-06-10'),
(103, 'Amit', 'IT', 65000, '2023-03-20'),
(104, 'Neha', 'Finance', 75000, '2020-09-12'),
(105, 'Rohan', 'HR', 48000, '2024-01-05'),
(106, 'Anjali', 'IT', 80000, '2022-11-18');
GO

-- Equal to
SELECT *
FROM dbo.Employees
WHERE Department = 'IT';
GO

-- Greater than
SELECT *
FROM dbo.Employees
WHERE Salary > 60000;
GO

-- Less than
SELECT *
FROM dbo.Employees
WHERE Salary < 60000;
GO

-- Not equal
SELECT *
FROM dbo.Employees
WHERE Department <> 'HR';
GO

-- Text filtering
SELECT *
FROM dbo.Employees
WHERE EmployeeName = 'Rahul';
GO

-- Date filtering
SELECT *
FROM dbo.Employees
WHERE HireDate >= '2022-01-01';
GO

-- Multiple conditions
SELECT *
FROM dbo.Employees
WHERE Department = 'IT'
AND Salary > 65000;
GO

-- Sorting ascending
SELECT *
FROM dbo.Employees
ORDER BY Salary ASC;
GO

-- Sorting descending
SELECT *
FROM dbo.Employees
ORDER BY Salary DESC;
GO