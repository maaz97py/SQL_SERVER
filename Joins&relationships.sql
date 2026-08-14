/* =========================================================
   MODULE: Joins & Relationships
   Topics:
   - Primary Keys
   - Foreign Keys
   - One-to-Many Relationships
   - INNER JOIN
   - LEFT JOIN
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.Enrollments;
DROP TABLE IF EXISTS dbo.Students;
GO

-- Parent Table
CREATE TABLE dbo.Students
(
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    City VARCHAR(50)
);
GO

-- Child Table
CREATE TABLE dbo.Enrollments
(
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    Course VARCHAR(100),

    CONSTRAINT FK_Enrollments_Students
    FOREIGN KEY (StudentID)
    REFERENCES dbo.Students(StudentID)
);
GO

-- Insert parent records
INSERT INTO dbo.Students
VALUES
(101, 'Rahul', 'Delhi'),
(102, 'Priya', 'Mumbai'),
(103, 'Amit', 'Hyderabad'),
(104, 'Neha', 'Chennai'),
(105, 'Rohan', 'Pune');
GO

-- Insert child records
INSERT INTO dbo.Enrollments
VALUES
(1, 101, 'SQL'),
(2, 101, 'Python'),
(3, 102, 'Power BI'),
(4, 103, 'SQL'),
(5, 105, 'Python');
GO

-- View tables
SELECT *
FROM dbo.Students;
GO

SELECT *
FROM dbo.Enrollments;
GO

-- INNER JOIN
SELECT
    s.StudentID,
    s.StudentName,
    e.Course
FROM dbo.Students s
INNER JOIN dbo.Enrollments e
    ON s.StudentID = e.StudentID;
GO

-- LEFT JOIN
SELECT
    s.StudentID,
    s.StudentName,
    e.Course
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e
    ON s.StudentID = e.StudentID;
GO

-- Students without enrollment
SELECT
    s.StudentID,
    s.StudentName
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e
    ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;
GO