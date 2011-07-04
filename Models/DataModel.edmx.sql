
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/29/2011 16:34:39
-- Generated from EDMX file: C:\Users\a.efimov\Dropbox\Programs\RSS\RSS\Models\DataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [RssDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[soksDBModelStoreContainer].[FK_Rss_To_Tag_Tags]', 'F') IS NOT NULL
    ALTER TABLE [soksDBModelStoreContainer].[UserFeeds_To_Tags] DROP CONSTRAINT [FK_Rss_To_Tag_Tags];
GO
IF OBJECT_ID(N'[soksDBModelStoreContainer].[FK_RssFeeds_To_UserFeeds_RssFeeds]', 'F') IS NOT NULL
    ALTER TABLE [soksDBModelStoreContainer].[UserFeeds_To_RssFeeds] DROP CONSTRAINT [FK_RssFeeds_To_UserFeeds_RssFeeds];
GO
IF OBJECT_ID(N'[soksDBModelStoreContainer].[FK_RssFeeds_To_UserFeeds_UserFeeds]', 'F') IS NOT NULL
    ALTER TABLE [soksDBModelStoreContainer].[UserFeeds_To_RssFeeds] DROP CONSTRAINT [FK_RssFeeds_To_UserFeeds_UserFeeds];
GO
IF OBJECT_ID(N'[dbo].[FK_UserFeeds_Filters]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserFeeds] DROP CONSTRAINT [FK_UserFeeds_Filters];
GO
IF OBJECT_ID(N'[soksDBModelStoreContainer].[FK_UserFeeds_To_Tags_UserFeeds]', 'F') IS NOT NULL
    ALTER TABLE [soksDBModelStoreContainer].[UserFeeds_To_Tags] DROP CONSTRAINT [FK_UserFeeds_To_Tags_UserFeeds];
GO
IF OBJECT_ID(N'[dbo].[FK_UserFeeds_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserFeeds] DROP CONSTRAINT [FK_UserFeeds_Users];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Filters]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Filters];
GO
IF OBJECT_ID(N'[dbo].[RssFeeds]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RssFeeds];
GO
IF OBJECT_ID(N'[dbo].[Tags]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tags];
GO
IF OBJECT_ID(N'[dbo].[UserFeeds]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserFeeds];
GO
IF OBJECT_ID(N'[soksDBModelStoreContainer].[UserFeeds_To_RssFeeds]', 'U') IS NOT NULL
    DROP TABLE [soksDBModelStoreContainer].[UserFeeds_To_RssFeeds];
GO
IF OBJECT_ID(N'[soksDBModelStoreContainer].[UserFeeds_To_Tags]', 'U') IS NOT NULL
    DROP TABLE [soksDBModelStoreContainer].[UserFeeds_To_Tags];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Filters'
CREATE TABLE [dbo].[Filters] (
    [ID] uniqueidentifier  NOT NULL,
    [FilterText] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'RssFeeds'
CREATE TABLE [dbo].[RssFeeds] (
    [ID] uniqueidentifier  NOT NULL,
    [Address] nvarchar(100)  NOT NULL,
    [Title] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Tags'
CREATE TABLE [dbo].[Tags] (
    [ID] uniqueidentifier  NOT NULL,
    [TagText] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'UserFeeds'
CREATE TABLE [dbo].[UserFeeds] (
    [ID] uniqueidentifier  NOT NULL,
    [User_ID] uniqueidentifier  NOT NULL,
    [IsPublic] bit  NOT NULL,
    [IsFavourite] bit  NOT NULL,
    [Filter_ID] uniqueidentifier  NOT NULL,
    [Title] nchar(32)  NOT NULL,
    [Description] nchar(128)  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [ID] uniqueidentifier  NOT NULL,
    [UserName] nvarchar(50)  NOT NULL,
    [Password] nvarchar(128)  NOT NULL,
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

-- Creating table 'UserFeeds_To_RssFeeds'
CREATE TABLE [dbo].[UserFeeds_To_RssFeeds] (
    [RssFeeds_ID] uniqueidentifier  NOT NULL,
    [UserFeeds_ID] uniqueidentifier  NOT NULL
);
GO

-- Creating table 'UserFeeds_To_Tags'
CREATE TABLE [dbo].[UserFeeds_To_Tags] (
    [Tags_ID] uniqueidentifier  NOT NULL,
    [UserFeeds_ID] uniqueidentifier  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Filters'
ALTER TABLE [dbo].[Filters]
ADD CONSTRAINT [PK_Filters]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RssFeeds'
ALTER TABLE [dbo].[RssFeeds]
ADD CONSTRAINT [PK_RssFeeds]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Tags'
ALTER TABLE [dbo].[Tags]
ADD CONSTRAINT [PK_Tags]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'UserFeeds'
ALTER TABLE [dbo].[UserFeeds]
ADD CONSTRAINT [PK_UserFeeds]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [RssFeeds_ID], [UserFeeds_ID] in table 'UserFeeds_To_RssFeeds'
ALTER TABLE [dbo].[UserFeeds_To_RssFeeds]
ADD CONSTRAINT [PK_UserFeeds_To_RssFeeds]
    PRIMARY KEY NONCLUSTERED ([RssFeeds_ID], [UserFeeds_ID] ASC);
GO

-- Creating primary key on [Tags_ID], [UserFeeds_ID] in table 'UserFeeds_To_Tags'
ALTER TABLE [dbo].[UserFeeds_To_Tags]
ADD CONSTRAINT [PK_UserFeeds_To_Tags]
    PRIMARY KEY NONCLUSTERED ([Tags_ID], [UserFeeds_ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Filter_ID] in table 'UserFeeds'
ALTER TABLE [dbo].[UserFeeds]
ADD CONSTRAINT [FK_UserFeeds_Filters]
    FOREIGN KEY ([Filter_ID])
    REFERENCES [dbo].[Filters]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserFeeds_Filters'
CREATE INDEX [IX_FK_UserFeeds_Filters]
ON [dbo].[UserFeeds]
    ([Filter_ID]);
GO

-- Creating foreign key on [User_ID] in table 'UserFeeds'
ALTER TABLE [dbo].[UserFeeds]
ADD CONSTRAINT [FK_UserFeeds_Users]
    FOREIGN KEY ([User_ID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserFeeds_Users'
CREATE INDEX [IX_FK_UserFeeds_Users]
ON [dbo].[UserFeeds]
    ([User_ID]);
GO

-- Creating foreign key on [RssFeeds_ID] in table 'UserFeeds_To_RssFeeds'
ALTER TABLE [dbo].[UserFeeds_To_RssFeeds]
ADD CONSTRAINT [FK_UserFeeds_To_RssFeeds_RssFeed]
    FOREIGN KEY ([RssFeeds_ID])
    REFERENCES [dbo].[RssFeeds]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [UserFeeds_ID] in table 'UserFeeds_To_RssFeeds'
ALTER TABLE [dbo].[UserFeeds_To_RssFeeds]
ADD CONSTRAINT [FK_UserFeeds_To_RssFeeds_UserFeed]
    FOREIGN KEY ([UserFeeds_ID])
    REFERENCES [dbo].[UserFeeds]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserFeeds_To_RssFeeds_UserFeed'
CREATE INDEX [IX_FK_UserFeeds_To_RssFeeds_UserFeed]
ON [dbo].[UserFeeds_To_RssFeeds]
    ([UserFeeds_ID]);
GO

-- Creating foreign key on [Tags_ID] in table 'UserFeeds_To_Tags'
ALTER TABLE [dbo].[UserFeeds_To_Tags]
ADD CONSTRAINT [FK_UserFeeds_To_Tags_Tag]
    FOREIGN KEY ([Tags_ID])
    REFERENCES [dbo].[Tags]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [UserFeeds_ID] in table 'UserFeeds_To_Tags'
ALTER TABLE [dbo].[UserFeeds_To_Tags]
ADD CONSTRAINT [FK_UserFeeds_To_Tags_UserFeed]
    FOREIGN KEY ([UserFeeds_ID])
    REFERENCES [dbo].[UserFeeds]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserFeeds_To_Tags_UserFeed'
CREATE INDEX [IX_FK_UserFeeds_To_Tags_UserFeed]
ON [dbo].[UserFeeds_To_Tags]
    ([UserFeeds_ID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------