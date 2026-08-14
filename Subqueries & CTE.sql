/* =========================================================
   MODULE: Subqueries & CTEs
   Topics:
   - Scalar Subqueries
   - Correlated Subqueries
   - CTEs
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
(106, 'Anjali', 'Finance', 72000);
GO

/*
=========================================================
SCALAR SUBQUERY
=========================================================
*/

-- Employees earning more than overall average salary

SELECT
    EmployeeID,
    EmployeeName,
    Salary
FROM dbo.Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM dbo.Employees
);
GO

/*
=========================================================
SCALAR SUBQUERY WITH SELECT
=========================================================
*/

SELECT
    EmployeeName,
    Salary,
    (
        SELECT AVG(Salary)
        FROM dbo.Employees
    ) AS CompanyAverageSalary
FROM dbo.Employees;
GO

/*
=========================================================
CORRELATED SUBQUERY
=========================================================

Find employees whose salary is greater than the
average salary of their own department.
*/

SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.Salary
FROM dbo.Employees e
WHERE e.Salary >
(
    SELECT AVG(e2.Salary)
    FROM dbo.Employees e2
    WHERE e2.Department = e.Department
);
GO

/*
=========================================================
COMMON TABLE EXPRESSION
=========================================================
*/

WITH DepartmentSalary AS
(
    SELECT
        Department,
        AVG(Salary) AS AverageSalary
    FROM dbo.Employees
    GROUP BY Department
)
SELECT *
FROM DepartmentSalary;
GO

/*
=========================================================
CTE + JOIN
=========================================================
*/

WITH DepartmentSalary AS
(
    SELECT
        Department,
        AVG(Salary) AS AverageSalary
    FROM dbo.Employees
    GROUP BY Department
)
SELECT
    e.EmployeeName,
    e.Department,
    e.Salary,
    d.AverageSalary
FROM dbo.Employees e
JOIN DepartmentSalary d
    ON e.Department = d.Department;
GO

/*
=========================================================
CTE WITH FILTERING
=========================================================
*/

WITH HighSalaryEmployees AS
(
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        Salary
    FROM dbo.Employees
    WHERE Salary > 60000
)
SELECT *
FROM HighSalaryEmployees;
GO