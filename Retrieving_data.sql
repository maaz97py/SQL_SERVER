/* =========================================================
   MODULE: Retrieving Data
   Topics:
   - SELECT
   - Column Selection
   - Aliases
   - Reading Table Data
   ========================================================= */

USE CompanyDB;
GO

-- Select all columns
SELECT *
FROM dbo.Students;
GO

-- Select specific columns
SELECT
    StudentID,
    StudentName,
    Course
FROM dbo.Students;
GO

-- Column aliases
SELECT
    StudentID AS ID,
    StudentName AS Name,
    Course AS Program
FROM dbo.Students;
GO

-- Multiple aliases
SELECT
    StudentID AS Student_Number,
    StudentName AS Student_Name,
    Email AS Email_Address,
    Age AS Student_Age
FROM dbo.Students;
GO

-- Calculated expression
SELECT
    StudentName,
    Age,
    Age + 1 AS Age_Next_Year
FROM dbo.Students;
GO