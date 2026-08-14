/* =========================================================
   MODULE: Views & Stored Procedures
   Topics:
   - Creating Views
   - Reusable Queries
   - Stored Procedure Basics
   - Execution
   ========================================================= */

USE CompanyDB;
GO

DROP VIEW IF EXISTS dbo.ITEmployees;
DROP VIEW IF EXISTS dbo.EmployeeDetails;
GO

DROP PROCEDURE IF EXISTS dbo.GetEmployees;
DROP PROCEDURE IF EXISTS dbo.GetEmployeesByDepartment;
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
(105, 'Rohan', 'HR', 48000);
GO

-- CREATE VIEW
CREATE VIEW dbo.EmployeeDetails
AS
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM dbo.Employees;
GO

-- Use View
SELECT *
FROM dbo.EmployeeDetails;
GO

-- Another View
CREATE VIEW dbo.ITEmployees
AS
SELECT
    EmployeeID,
    EmployeeName,
    Salary
FROM dbo.Employees
WHERE Department = 'IT';
GO

SELECT *
FROM dbo.ITEmployees;
GO

-- CREATE STORED PROCEDURE
CREATE PROCEDURE dbo.GetEmployees
AS
BEGIN
    SELECT *
    FROM dbo.Employees;
END;
GO

-- Execute Procedure
EXEC dbo.GetEmployees;
GO

-- Stored Procedure with Parameter
CREATE PROCEDURE dbo.GetEmployeesByDepartment
    @Department VARCHAR(50)
AS
BEGIN
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        Salary
    FROM dbo.Employees
    WHERE Department = @Department;
END;
GO

-- Execute with parameter
EXEC dbo.GetEmployeesByDepartment
    @Department = 'IT';
GO

EXEC dbo.GetEmployeesByDepartment
    @Department = 'HR';
GO

-- Modify procedure
ALTER PROCEDURE dbo.GetEmployeesByDepartment
    @Department VARCHAR(50)
AS
BEGIN
    SELECT
        EmployeeName,
        Salary
    FROM dbo.Employees
    WHERE Department = @Department;
END;
GO

EXEC dbo.GetEmployeesByDepartment
    @Department = 'Finance';
GO