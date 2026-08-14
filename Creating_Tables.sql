/* =========================================================
   MODULE: Creating Tables
   Topics:
   - Data Types
   - Primary Keys
   - NULL vs NOT NULL
   - CREATE TABLE
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.Students;
GO

CREATE TABLE dbo.Students
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NULL,
    Age INT NOT NULL,
    Course VARCHAR(100) NULL
);
GO

-- View table structure
EXEC sp_help 'dbo.Students';
GO

-- Insert sample data
INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    Email,
    Age,
    Course
)
VALUES
(101, 'Rahul', 'rahul@gmail.com', 22, 'SQL'),
(102, 'Priya', 'priya@gmail.com', 23, 'Python'),
(103, 'Amit', NULL, 21, 'Power BI');
GO

-- View records
SELECT *
FROM dbo.Students;
GO