/* =========================================================
   MODULE: Constraints
   Topics:
   - UNIQUE
   - CHECK
   - DEFAULT
   - Constraint Management
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.ConstraintDemo;
GO

CREATE TABLE dbo.ConstraintDemo
(
    EmployeeID INT PRIMARY KEY,

    Email VARCHAR(150)
        CONSTRAINT UQ_ConstraintDemo_Email UNIQUE,

    Age INT
        CONSTRAINT CK_ConstraintDemo_Age CHECK (Age >= 18),

    City VARCHAR(50)
        CONSTRAINT DF_ConstraintDemo_City DEFAULT 'Bengaluru'
);
GO

-- Valid insert
INSERT INTO dbo.ConstraintDemo
(
    EmployeeID,
    Email,
    Age,
    City
)
VALUES
(
    101,
    'rahul@gmail.com',
    25,
    'Delhi'
);
GO

-- DEFAULT constraint
INSERT INTO dbo.ConstraintDemo
(
    EmployeeID,
    Email,
    Age
)
VALUES
(
    102,
    'priya@gmail.com',
    23
);
GO

SELECT *
FROM dbo.ConstraintDemo;
GO

-- Test UNIQUE constraint
-- This will fail because email already exists.
-- INSERT INTO dbo.ConstraintDemo
-- VALUES (103, 'rahul@gmail.com', 30, 'Mumbai');

-- Test CHECK constraint
-- This will fail because Age is less than 18.
-- INSERT INTO dbo.ConstraintDemo
-- VALUES (104, 'amit@gmail.com', 16, 'Pune');

-- View constraints
SELECT
    name AS ConstraintName,
    type_desc AS ConstraintType
FROM sys.objects
WHERE parent_object_id = OBJECT_ID('dbo.ConstraintDemo')
AND type IN ('PK', 'UQ', 'C', 'D');
GO

-- Add a new CHECK constraint
ALTER TABLE dbo.ConstraintDemo
ADD CONSTRAINT CK_ConstraintDemo_Email
CHECK (Email LIKE '%@%');
GO

-- Remove the CHECK constraint
ALTER TABLE dbo.ConstraintDemo
DROP CONSTRAINT CK_ConstraintDemo_Email;
GO