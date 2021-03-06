USE [WorkoutDB]
GO
/****** Object:  StoredProcedure [dbo].[getVisitsByUserDateRange]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP PROCEDURE [dbo].[getVisitsByUserDateRange]
GO
ALTER TABLE [dbo].[Visit] DROP CONSTRAINT [CK_CHECKOUT]
GO
ALTER TABLE [dbo].[Visit] DROP CONSTRAINT [CK_CHECKIN]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [CK_CREATIONDATE]
GO
ALTER TABLE [dbo].[Visit] DROP CONSTRAINT [FK_Visit_User]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[UsageDetails] DROP CONSTRAINT [FK_UsageDetails_Visit]
GO
ALTER TABLE [dbo].[UsageDetails] DROP CONSTRAINT [FK_UsageDetails_Equipment]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_User_CreationDate]
GO
ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_User_RoleId]
GO
/****** Object:  Index [UC_Email]    Script Date: 12/12/2019 9:33:56 AM ******/
ALTER TABLE [dbo].[User] DROP CONSTRAINT [UC_Email]
GO
/****** Object:  Index [UC_DisplayName]    Script Date: 12/12/2019 9:33:56 AM ******/
ALTER TABLE [dbo].[User] DROP CONSTRAINT [UC_DisplayName]
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP TABLE [dbo].[Visit]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[UsageDetails]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP TABLE [dbo].[UsageDetails]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP TABLE [dbo].[Role]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP TABLE [dbo].[Equipment]
GO
USE [master]
GO
/****** Object:  Database [WorkoutDB]    Script Date: 12/12/2019 9:33:56 AM ******/
DROP DATABASE [WorkoutDB]
GO
/****** Object:  Database [WorkoutDB]    Script Date: 12/12/2019 9:33:56 AM ******/
CREATE DATABASE [WorkoutDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WorkoutDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\WorkoutDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WorkoutDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\WorkoutDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [WorkoutDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WorkoutDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WorkoutDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WorkoutDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WorkoutDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WorkoutDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WorkoutDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WorkoutDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [WorkoutDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WorkoutDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WorkoutDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WorkoutDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WorkoutDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WorkoutDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WorkoutDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WorkoutDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WorkoutDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WorkoutDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WorkoutDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WorkoutDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WorkoutDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WorkoutDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WorkoutDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WorkoutDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WorkoutDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WorkoutDB] SET  MULTI_USER 
GO
ALTER DATABASE [WorkoutDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WorkoutDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WorkoutDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WorkoutDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WorkoutDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WorkoutDB] SET QUERY_STORE = OFF
GO
USE [WorkoutDB]
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Category] [nchar](10) NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsageDetails]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsageDetails](
	[VisitId] [int] NOT NULL,
	[EquipmentId] [int] NOT NULL,
	[Reps] [int] NULL,
	[Weight] [int] NULL,
	[Duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[Salt] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[RoleId] [int] NOT NULL,
	[ImageURL] [nvarchar](max) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Goals] [nvarchar](max) NOT NULL,
	[DisplayName] [varchar](50) NOT NULL,
	[ExperienceLevel] [varchar](50) NULL,
	[WeeklyExercise] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CheckIn] [datetime] NOT NULL,
	[CheckOut] [datetime] NULL,
 CONSTRAINT [PK_Visit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Equipment] ON 

INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (3, N'Treadmill ', N'Fitness', N'Cardio    ')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (4, N'Stairmaster', N'Fitness', N'Cardio    ')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (5, N'Bench Press', N'Chest', N'Resistance')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (6, N'Fly', N'Chest', N'Resistance')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (7, N'Rowing Machine', N'Fitness', N'Cardio    ')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (8, N'Leg Press', N'Legs', N'Resistance')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (9, N'Leg Extension Machine', N'Legs', N'Resistance')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (10, N'Arm Curl Machine', N'Arms', N'Resistance')
INSERT [dbo].[Equipment] ([Id], [Name], [Description], [Category]) VALUES (11, N'Tricep Extension Machine', N'Arms', N'Resistance')
SET IDENTITY_INSERT [dbo].[Equipment] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Member')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Employee')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [LastName], [Hash], [Salt], [Email], [RoleId], [ImageURL], [CreationDate], [Goals], [DisplayName], [ExperienceLevel], [WeeklyExercise]) VALUES (1, N'Cameron', N'Pleshek', N'Wrnnm+GuOj88je3KgWnlrnuTwcc=', N'o8CyqXZDu0IZHE47LgSgIQ==', N'pleshekc@gmail.com', 3, N'https://www.sackettwaconia.com/wp-content/uploads/default-profile.png', CAST(N'2019-12-10T17:07:19.287' AS DateTime), N'Get Abs', N'pleshekc', NULL, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[Visit] ON 

INSERT [dbo].[Visit] ([Id], [UserId], [CheckIn], [CheckOut]) VALUES (1, 1, CAST(N'2019-12-10T08:21:04.740' AS DateTime), CAST(N'2019-12-10T13:51:04.740' AS DateTime))
INSERT [dbo].[Visit] ([Id], [UserId], [CheckIn], [CheckOut]) VALUES (2, 1, CAST(N'2019-12-10T08:21:08.693' AS DateTime), CAST(N'2019-12-10T13:51:08.693' AS DateTime))
INSERT [dbo].[Visit] ([Id], [UserId], [CheckIn], [CheckOut]) VALUES (3, 1, CAST(N'2019-12-11T08:22:24.737' AS DateTime), CAST(N'2019-12-11T10:22:24.737' AS DateTime))
SET IDENTITY_INSERT [dbo].[Visit] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_DisplayName]    Script Date: 12/12/2019 9:33:57 AM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UC_DisplayName] UNIQUE NONCLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_Email]    Script Date: 12/12/2019 9:33:57 AM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UC_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_RoleId]  DEFAULT ((1)) FOR [RoleId]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[UsageDetails]  WITH CHECK ADD  CONSTRAINT [FK_UsageDetails_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[UsageDetails] CHECK CONSTRAINT [FK_UsageDetails_Equipment]
GO
ALTER TABLE [dbo].[UsageDetails]  WITH CHECK ADD  CONSTRAINT [FK_UsageDetails_Visit] FOREIGN KEY([VisitId])
REFERENCES [dbo].[Visit] ([Id])
GO
ALTER TABLE [dbo].[UsageDetails] CHECK CONSTRAINT [FK_UsageDetails_Visit]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_CREATIONDATE] CHECK  (([CreationDate]<=getdate()))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_CREATIONDATE]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [CK_CHECKIN] CHECK  (([CheckIn]<=getdate()))
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [CK_CHECKIN]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [CK_CHECKOUT] CHECK  (([CheckOut]>[CheckIn]))
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [CK_CHECKOUT]
GO
/****** Object:  StoredProcedure [dbo].[getVisitsByUserDateRange]    Script Date: 12/12/2019 9:33:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getVisitsByUserDateRange]
@userid int,
@dtstart datetime,
@dtend datetime
AS 
SELECT * 
FROM Visit
WHERE UserId=@userid
AND CheckIn BETWEEN @dtstart AND @dtend;
GO
USE [master]
GO
ALTER DATABASE [WorkoutDB] SET  READ_WRITE 
GO
