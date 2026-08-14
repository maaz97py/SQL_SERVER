/* =========================================================
   MODULE: Import & Export
   Topics:
   - Import Wizard
   - Export to CSV
   - Data Validation
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.ImportEmployees;
GO

CREATE TABLE dbo.ImportEmployees
(
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

/*
=========================================================
IMPORT FROM CSV
=========================================================

For the SSMS Import Wizard:

Right-click CompanyDB
    -> Tasks
    -> Import Data

Source:
    Flat File Source

Destination:
    Microsoft OLE DB Driver for SQL Server

For SQL Server 2022 / modern SSMS:
Use Microsoft OLE DB Driver for SQL Server (MSOLEDBSQL),
NOT SQL Server Native Client.
*/

/*
Example CSV:

EmployeeID,EmployeeName,Department,Salary
101,Rahul,IT,70000
102,Priya,HR,50000
103,Amit,Finance,65000
104,Neha,IT,75000
105,Rohan,HR,48000
*/

/*
=========================================================
OPTIONAL T-SQL IMPORT
=========================================================

The following is an alternative to the GUI wizard.

Change the file path before running.
*/

/*
BULK INSERT dbo.ImportEmployees
FROM 'C:\SQLData\Employees.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
*/

/*
=========================================================
DATA VALIDATION
=========================================================
*/

-- View imported records
SELECT *
FROM dbo.ImportEmployees;
GO

-- Count imported records
SELECT COUNT(*) AS TotalRecords
FROM dbo.ImportEmployees;
GO

-- Check NULL values
SELECT *
FROM dbo.ImportEmployees
WHERE EmployeeID IS NULL
   OR EmployeeName IS NULL
   OR Department IS NULL
   OR Salary IS NULL;
GO

-- Check duplicate Employee IDs
SELECT
    EmployeeID,
    COUNT(*) AS DuplicateCount
FROM dbo.ImportEmployees
GROUP BY EmployeeID
HAVING COUNT(*) > 1;
GO

/*
=========================================================
EXPORT TO CSV
=========================================================

Use:

Right-click CompanyDB
    -> Tasks
    -> Export Data

Destination:
    Flat File Destination

File:
    Employees.csv

Format:
    Delimited

Column delimiter:
    Comma

Alternatively, data can be exported using bcp
from the Windows Command Prompt:

bcp "SELECT EmployeeID, EmployeeName, Department, Salary
FROM CompanyDB.dbo.ImportEmployees"
queryout "C:\SQLData\Employees.csv"
-c -t, -T -S MAAZ\SQLEXPRESS

-T = Windows Authentication
-S = SQL Server instance
-c = Character format
-t, = Comma delimiter
*/