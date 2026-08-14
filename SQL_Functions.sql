/* =========================================================
   MODULE: SQL Functions
   Topics:
   - String Functions
   - Numeric Functions
   - Date Functions
   - Expressions
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.Employees;
GO

CREATE TABLE dbo.Employees
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2),
    HireDate DATE
);
GO

INSERT INTO dbo.Employees
VALUES
(101, 'Rahul Kumar', 70000, '2022-01-15'),
(102, 'Priya Sharma', 55000, '2021-06-10'),
(103, 'Amit Singh', 65000, '2023-03-20');
GO

-- STRING FUNCTIONS

SELECT
    EmployeeName,
    UPPER(EmployeeName) AS UpperName,
    LOWER(EmployeeName) AS LowerName
FROM dbo.Employees;
GO

SELECT
    EmployeeName,
    LEN(EmployeeName) AS NameLength
FROM dbo.Employees;
GO

SELECT
    EmployeeName,
    LEFT(EmployeeName, 5) AS FirstFiveCharacters
FROM dbo.Employees;
GO

SELECT
    EmployeeName,
    RIGHT(EmployeeName, 5) AS LastFiveCharacters
FROM dbo.Employees;
GO

-- NUMERIC FUNCTIONS

SELECT
    Salary,
    ROUND(Salary / 1000, 2) AS SalaryInThousands
FROM dbo.Employees;
GO

SELECT
    Salary,
    CEILING(Salary / 1000.0) AS RoundedUp
FROM dbo.Employees;
GO

SELECT
    Salary,
    FLOOR(Salary / 1000.0) AS RoundedDown
FROM dbo.Employees;
GO

-- DATE FUNCTIONS

SELECT
    EmployeeName,
    HireDate,
    YEAR(HireDate) AS HireYear,
    MONTH(HireDate) AS HireMonth,
    DAY(HireDate) AS HireDay
FROM dbo.Employees;
GO

SELECT
    EmployeeName,
    HireDate,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked
FROM dbo.Employees;
GO

-- EXPRESSIONS

SELECT
    EmployeeName,
    Salary,
    Salary * 12 AS AnnualSalary,
    Salary * 12 * 0.10 AS AnnualBonus
FROM dbo.Employees;
GO