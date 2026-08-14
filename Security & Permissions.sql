/* =========================================================
   MODULE: Security & Permissions
   Topics:
   - Logins vs Users
   - Roles
   - Permissions
   - Least Privilege Principle
   ========================================================= */

/*
IMPORTANT:
The LOGIN section requires appropriate server-level
permissions, usually sysadmin.

Run this section only in a local training environment.
*/

USE master;
GO

-- Create SQL Server Login
IF NOT EXISTS
(
    SELECT 1
    FROM sys.server_principals
    WHERE name = 'TrainingLogin'
)
BEGIN
    CREATE LOGIN TrainingLogin
    WITH PASSWORD = 'Training@12345';
END;
GO

-- View logins
SELECT
    name,
    type_desc
FROM sys.server_principals
WHERE name = 'TrainingLogin';
GO

USE CompanyDB;
GO

-- Create database user for login
IF NOT EXISTS
(
    SELECT 1
    FROM sys.database_principals
    WHERE name = 'TrainingUser'
)
BEGIN
    CREATE USER TrainingUser
    FOR LOGIN TrainingLogin;
END;
GO

-- Create custom role
IF NOT EXISTS
(
    SELECT 1
    FROM sys.database_principals
    WHERE name = 'ReportingRole'
)
BEGIN
    CREATE ROLE ReportingRole;
END;
GO

-- Grant SELECT permission
GRANT SELECT
ON dbo.Employees
TO ReportingRole;
GO

-- Add user to role
ALTER ROLE ReportingRole
ADD MEMBER TrainingUser;
GO

-- View role membership
SELECT
    role_principal.name AS RoleName,
    member_principal.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals role_principal
    ON drm.role_principal_id = role_principal.principal_id
JOIN sys.database_principals member_principal
    ON drm.member_principal_id = member_principal.principal_id
WHERE member_principal.name = 'TrainingUser';
GO

-- Check permissions
SELECT
    *
FROM fn_my_permissions('dbo.Employees', 'OBJECT');
GO

/*
=========================================================
LEAST PRIVILEGE PRINCIPLE
=========================================================

Instead of giving the user:

db_owner

we give only:

SELECT

This allows the user to read the required data
without giving unnecessary permissions.
*/

/*
Example permission management:

GRANT SELECT ON dbo.Employees TO ReportingRole;

DENY DELETE ON dbo.Employees TO ReportingRole;

REVOKE SELECT ON dbo.Employees FROM ReportingRole;
*/