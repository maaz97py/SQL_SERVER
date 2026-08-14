/* =========================================================
   MODULE: Transactions & Error Handling
   Topics:
   - BEGIN TRANSACTION
   - COMMIT
   - ROLLBACK
   - TRY...CATCH
   ========================================================= */

USE CompanyDB;
GO

DROP TABLE IF EXISTS dbo.TransactionEmployees;
GO

CREATE TABLE dbo.TransactionEmployees
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2)
);
GO

INSERT INTO dbo.TransactionEmployees
VALUES
(101, 'Rahul', 70000),
(102, 'Priya', 50000),
(103, 'Amit', 65000);
GO

-- View initial data
SELECT *
FROM dbo.TransactionEmployees;
GO

/*
=========================================================
COMMIT
=========================================================
*/

BEGIN TRANSACTION;

UPDATE dbo.TransactionEmployees
SET Salary = Salary + 5000
WHERE EmployeeID = 101;

SELECT *
FROM dbo.TransactionEmployees
WHERE EmployeeID = 101;

COMMIT TRANSACTION;
GO

SELECT *
FROM dbo.TransactionEmployees
WHERE EmployeeID = 101;
GO

/*
=========================================================
ROLLBACK
=========================================================
*/

BEGIN TRANSACTION;

UPDATE dbo.TransactionEmployees
SET Salary = Salary + 10000
WHERE EmployeeID = 102;

SELECT *
FROM dbo.TransactionEmployees
WHERE EmployeeID = 102;

ROLLBACK TRANSACTION;
GO

SELECT *
FROM dbo.TransactionEmployees
WHERE EmployeeID = 102;
GO

/*
=========================================================
TRY...CATCH
=========================================================
*/

BEGIN TRY

    BEGIN TRANSACTION;

    -- Duplicate primary key intentionally causes an error
    INSERT INTO dbo.TransactionEmployees
    VALUES
    (101, 'Duplicate Employee', 55000);

    COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_LINE() AS ErrorLine;

END CATCH;
GO

/*
=========================================================
SUCCESSFUL TRANSACTION WITH TRY...CATCH
=========================================================
*/

BEGIN TRY

    BEGIN TRANSACTION;

    UPDATE dbo.TransactionEmployees
    SET Salary = Salary + 2000
    WHERE EmployeeID = 103;

    COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;

END CATCH;
GO

SELECT *
FROM dbo.TransactionEmployees;
GO