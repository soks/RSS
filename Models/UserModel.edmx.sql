
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/27/2011 13:06:38
-- Generated from EDMX file: C:\Users\Dixon\Desktop\RSS\RSS\Models\UserModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Users];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [ID] int  NOT NULL,
    [UserName] nvarchar(50)  NOT NULL,
    [Password] nvarchar(50)  NOT NULL,
    [Email] nvarchar(50)  NOT NULL,
    [LastUpdate] datetime  NOT NULL,
    [PasswordSolt] nvarchar(128)  NOT NULL,
    [Comments] nvarchar(256)  NULL,
    [CreatedDate] datetime  NOT NULL,
    [LastModifiedDate] datetime  NULL,
    [LastLoginDate] datetime  NOT NULL,
    [LastLoginIP] nvarchar(40)  NULL,
    [IsActivated] bit  NOT NULL,
    [IsLockedOut] bit  NOT NULL,
    [LastLockedOutDate] datetime  NOT NULL,
    [LastLockedOutReason] nchar(10)  NULL,
    [NewPasswordKey] nvarchar(128)  NULL,
    [NewPasswordRequested] datetime  NULL,
    [NewEmail] nvarchar(100)  NULL,
    [NewEmailKey] nvarchar(128)  NULL,
    [NewEmailRequsted] datetime  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------