/* =========================================================
   MODULE: Creating Databases
   Topics:
   - Database Concepts
   - Schemas
   - Naming Standards
   - CREATE DATABASE
   ========================================================= */

-- Create Database
IF DB_ID('CompanyDB') IS NULL
BEGIN
    CREATE DATABASE CompanyDB;
END;
GO

-- Switch to Database
USE CompanyDB;
GO

-- Create a Schema
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'Sales'
)
BEGIN
    EXEC('CREATE SCHEMA Sales');
END;
GO

-- Create another schema
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'HR'
)
BEGIN
    EXEC('CREATE SCHEMA HR');
END;
GO

-- Verify schemas
SELECT
    name AS SchemaName
FROM sys.schemas
WHERE name IN ('Sales', 'HR');

-- Verify database
SELECT
    name AS DatabaseName
FROM sys.databases
WHERE name = 'CompanyDB';
GO