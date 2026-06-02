-- ============================================================
--  Car Rental Platform – Database Setup Script
--  Database: MS SQL Server
--  Author  : SWP391 Team
--  Date    : 2026
-- ============================================================

-- 1. Create & select the database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'CarRentalDB')
BEGIN
    CREATE DATABASE CarRentalDB;
END
GO

USE CarRentalDB;
GO

-- ============================================================
--  2. ENUM simulation via CHECK constraints
--     Roles  : RENTER | CAR_OWNER | ADMIN | STAFF
--     Status : ACTIVE | INACTIVE | BANNED
-- ============================================================

-- ============================================================
--  3. Users Table
-- ============================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type = N'U')
BEGIN
    CREATE TABLE dbo.Users (
        UserID      INT           IDENTITY(1,1) PRIMARY KEY,
        Email       NVARCHAR(255) NOT NULL UNIQUE,
        -- BCrypt hash stored as VARCHAR(60)
        Password    VARCHAR(60)   NOT NULL,
        FullName    NVARCHAR(150) NOT NULL,
        Phone       VARCHAR(20)   NULL,
        -- Role controls dashboard access (see AuthenticationFilter.java)
        Role        VARCHAR(20)   NOT NULL
                        CONSTRAINT CK_Users_Role
                        CHECK (Role IN ('RENTER', 'CAR_OWNER', 'ADMIN', 'STAFF')),
        Status      VARCHAR(20)   NOT NULL DEFAULT 'ACTIVE'
                        CONSTRAINT CK_Users_Status
                        CHECK (Status IN ('ACTIVE', 'INACTIVE', 'BANNED')),
        CreatedAt   DATETIME      NOT NULL DEFAULT GETDATE(),
        UpdatedAt   DATETIME      NULL
    );
END
GO

-- ============================================================
--  4. Seed Data – Default Admin account
--     BCrypt hash below = BCrypt.hashpw("Admin@123", BCrypt.gensalt(12))
--     Re-generate this hash using the application's BCrypt utility
--     before deploying to production.
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Email = 'admin@carrental.com')
BEGIN
    INSERT INTO dbo.Users (Email, [Password], FullName, Phone, Role, Status)
    VALUES (
        'admin@carrental.com',
        '$2a$12$s8Y2VJPvHtPiP2lBGNc7p.X2XdR9Oe7qKpLzMNe0jFkYwY1fDlXbm',  -- Admin@123
        N'System Administrator',
        '0900000000',
        'ADMIN',
        'ACTIVE'
    );
END
GO

-- ============================================================
--  5. Useful indexes
-- ============================================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_Users_Email')
    CREATE NONCLUSTERED INDEX IX_Users_Email ON dbo.Users(Email);
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_Users_Role')
    CREATE NONCLUSTERED INDEX IX_Users_Role ON dbo.Users(Role);
GO

-- ============================================================
--  6. Quick sanity check
-- ============================================================
SELECT UserID, Email, FullName, Role, Status, CreatedAt
FROM dbo.Users;
GO
