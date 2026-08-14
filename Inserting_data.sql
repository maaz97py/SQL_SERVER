/* =========================================================
   MODULE: Inserting Data
   Topics:
   - INSERT INTO
   - Single Row Insert
   - Multiple Row Insert
   - Verifying Records
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.Students;
GO

CREATE TABLE dbo.Students
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(150),
    Age INT,
    Course VARCHAR(100)
);
GO

-- Single Row Insert
INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    Email,
    Age,
    Course
)
VALUES
(
    101,
    'Rahul',
    'rahul@gmail.com',
    22,
    'SQL'
);
GO

-- Another single row
INSERT INTO dbo.Students
VALUES
(
    102,
    'Priya',
    'priya@gmail.com',
    23,
    'Python'
);
GO

-- Multiple Row Insert
INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    Email,
    Age,
    Course
)
VALUES
(103, 'Amit', 'amit@gmail.com', 21, 'Power BI'),
(104, 'Neha', 'neha@gmail.com', 24, 'SQL'),
(105, 'Rohan', NULL, 22, 'Python');
GO

-- Verify all records
SELECT *
FROM dbo.Students;
GO

-- Verify record count
SELECT COUNT(*) AS TotalStudents
FROM dbo.Students;
GO