USE [master]
GO
/****** Object:  Database [SonaClock]    Script Date: 8/15/2023 10:58:58 PM ******/
CREATE DATABASE [SonaClock]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SonaHotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SonaHotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SonaHotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SonaHotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SonaClock] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SonaClock].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SonaClock] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SonaClock] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SonaClock] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SonaClock] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SonaClock] SET ARITHABORT OFF 
GO
ALTER DATABASE [SonaClock] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SonaClock] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SonaClock] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SonaClock] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SonaClock] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SonaClock] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SonaClock] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SonaClock] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SonaClock] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SonaClock] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SonaClock] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SonaClock] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SonaClock] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SonaClock] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SonaClock] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SonaClock] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SonaClock] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SonaClock] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SonaClock] SET  MULTI_USER 
GO
ALTER DATABASE [SonaClock] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SonaClock] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SonaClock] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SonaClock] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SonaClock] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SonaClock] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SonaClock] SET QUERY_STORE = OFF
GO
USE [SonaClock]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[Fullname] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [char](10) NOT NULL,
	[Firstname] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NULL,
 CONSTRAINT [PK__Accounts__536C85E5C00863D6] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authorities]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authorities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[RoleId] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [char](4) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NULL,
	[ProductId] [int] NULL,
	[Price] [float] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK__OrderDet__3214EC0704395FCB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Address] [nvarchar](100) NULL,
	[status_id] [int] NULL,
 CONSTRAINT [PK__Orders__3214EC0774ADB725] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_status]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_status](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Image] [nvarchar](50) NULL,
	[Price] [float] NULL,
	[CreateDate] [date] NULL,
	[Available] [bit] NULL,
	[category_id] [char](4) NULL,
 CONSTRAINT [PK__Products__3214EC073896D647] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[verification_token]    Script Date: 8/15/2023 10:58:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[verification_token](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[token] [varchar](255) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[expiry_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'123', N'Toan@123', N'456', N'456@gmail.com', N'1234567890', N'1', N'2')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'1234', N'1234578@Ff', N'123456', N'f@gmail.com', N'1234567890', N'1', N'2')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'a', N'$2a$10$I9ciIPd6oeI7SRGItqEAHu0rqP6/b4dFrEoz3BPbviSgal.qAqqhm', N'Nguyễn Văn A', N'sdfsdf@gmail.com', N'0123456789', N'Nguyễn Văn ', N'A')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'aanh', N'$2a$10$JkkkyJbF60WEiJYPAPq1LuPW7suoaknjbxPK.wliyJQRfml//xUBG', N'Nguyễn Văn Aanh', N'sdfsdf@gmail.com', N'0123456789', N'Nguyễn ', N'1')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'cuong', N'$2a$10$JaMo7octyl.OSEHKaXPA/O09PwJ6cBE64wvweflpf4REa2lLMwDSa', N'Kim Văn Cường', N'cuongkvps25207@fpt.edu.vn', N'0145786150', N'Kim Văn ', N'Cường')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'customer', N'$2a$10$D.IHR/5Pk8csoJ3TKWNNC.8sNt3POSrCB37J4y/avE9.26I9NAKga', N'Customer', N'andew@gmail.com', N'0123456780', N'customer', N'customer')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'danh', N'$2a$10$COuZq94z4CmY5rP25XVDUuVDgY5DPTNtd8bQQ4OIScZ4V6m2gBt3W', N'danh', N'abc@gmail.com', N'0825566678', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'director', N'$2a$10$PiOWWy55jF1e0LwJbUchLeRlJwknKIX2VFsL9OOQTGsiNyGTx6TWi', N'Driector', N'director@gmail.com', N'0123456789', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'hung', N'$2a$10$e35ykJCqTWxxfAXZsbT2LuWTULhsV.I4C32MLGLxZl1jf.tDO9ezy', N'Bùi Hải Hưng', N'hung@gmail.com', N'0456781540', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'long', N'$2a$10$ihiWslng5vHGrCrsXxZ6AOfNtZp7GE1VXaC3g4LrSf0CZMKV2FLUW', N'Hoàng Phi Long', N'long123@gmail.com', N'0123456789', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'teo', N'/XKyJEmuX0eHK5Y9rysIRdKjNvk=123456sadfqo*ewi&uchvkaj131s1&6#87dfui@343', N'Nguyen Van Teo', N'andew@gmail.com', N'0878941125', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'toan', N'$2a$10$MnZURJUcQTYL7qkhyQ6htedqjcYCZ3iBDI1FnTiJLtcFQ4X6NI1yi', N'Vũ Văn Toàn', N'toanvu2311@gmail.com', N'0023456789', NULL, NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Phone], [Firstname], [Lastname]) VALUES (N'user', N'$2a$10$pSEnzBAQaaEXMs5JusYpEuS68P1gXbSVFXhEqFqojL6gqfoP/eUuK', N'Nguyen Van Teo', N'cuongkvps25207@fpt.edu.vn', N'0012345678', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Authorities] ON 

INSERT [dbo].[Authorities] ([Id], [Username], [RoleId]) VALUES (5, N'cuong', N'DIR')
INSERT [dbo].[Authorities] ([Id], [Username], [RoleId]) VALUES (10, N'director', N'DIR')
SET IDENTITY_INSERT [dbo].[Authorities] OFF
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'102 ', N'Ðồng hồ đeo tay')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'103 ', N'Ðồng hồ thông minh')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'104 ', N'Ðồng hồ treo tường')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'105 ', N'Ðồng hồ cơ')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'106 ', N'Ðồng hồ bấm giờ')
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1061, 167, 101, 1200000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1062, 167, 102, 780000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1063, 167, 104, 186000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1064, 167, 108, 474000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1065, 167, 111, 457000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1066, 168, 102, 780000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1067, 168, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1068, 169, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1069, 169, 104, 186000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1070, 170, 102, 780000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1071, 170, 104, 186000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1072, 171, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1073, 171, 101, 1200000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1074, 171, 108, 474000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1075, 171, 106, 278000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1076, 171, 110, 500000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1077, 171, 113, 842000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1078, 172, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1079, 172, 101, 1200000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1080, 173, 102, 780000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1081, 173, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1082, 174, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1083, 174, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1084, 175, 102, 780000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1085, 175, 104, 186000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1086, 175, 108, 474000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1087, 175, 109, 56000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1088, 176, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1089, 176, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1090, 177, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1091, 177, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1092, 178, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1093, 178, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1094, 179, 101, 1200000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1095, 180, 101, 1200000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1096, 180, 106, 278000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1097, 180, 108, 474000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1098, 180, 109, 56000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1099, 181, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1100, 181, 104, 186000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1101, 182, 102, 780000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1102, 182, 104, 186000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1103, 182, 109, 56000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1104, 182, 116, 672123, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1105, 182, 115, 570000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1106, 183, 102, 780000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1107, 183, 116, 672123, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1108, 183, 115, 570000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1109, 183, 114, 615000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1110, 184, 102, 780000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1111, 184, 101, 1200000, 2)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (167, N'cuong', CAST(N'2023-08-05T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (168, N'hung', CAST(N'2023-08-06T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (169, N'hung', CAST(N'2023-08-07T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (170, N'toan', CAST(N'2023-08-07T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (171, N'customer', CAST(N'2023-08-08T00:00:00.000' AS DateTime), N'TPHCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (172, N'cuong', CAST(N'2023-08-08T00:00:00.000' AS DateTime), N'TPHCM', 3)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (173, N'cuong', CAST(N'2023-08-11T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (174, N'toan', CAST(N'2023-08-12T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (175, N'cuong', CAST(N'2023-08-13T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (176, N'cuong', CAST(N'2023-08-14T00:00:00.000' AS DateTime), N'TP HCM', 3)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (177, N'cuong', CAST(N'2023-08-14T00:00:00.000' AS DateTime), N'TP HCM', 3)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (178, N'cuong', CAST(N'2023-08-14T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (179, N'hung', CAST(N'2023-08-14T00:00:00.000' AS DateTime), N'TP HCM', 4)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (180, N'toan', CAST(N'2023-08-14T00:00:00.000' AS DateTime), N'TP HCM', 3)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (181, N'cuong', CAST(N'2023-08-15T00:00:00.000' AS DateTime), NULL, 3)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (182, N'cuong', CAST(N'2023-08-15T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (183, N'toan', CAST(N'2023-08-15T00:00:00.000' AS DateTime), NULL, 1)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status_id]) VALUES (184, N'toan', CAST(N'2023-08-15T00:00:00.000' AS DateTime), N'123 123 123', 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[orders_status] ([Id], [Name]) VALUES (1, N'Đặt hàng')
INSERT [dbo].[orders_status] ([Id], [Name]) VALUES (2, N'Xác nhận')
INSERT [dbo].[orders_status] ([Id], [Name]) VALUES (3, N'Hủy')
INSERT [dbo].[orders_status] ([Id], [Name]) VALUES (4, N'Thành công')
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (101, N'Apple Watch', N'apple.jpg', 1200000, CAST(N'2023-07-17' AS Date), 1, N'102 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (102, N'Tag Heurer', N'tag.jpg', 780000, CAST(N'2023-07-17' AS Date), 1, N'103 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (104, N'QUARTZ', N'quartz.jpg', 186000, CAST(N'2023-07-17' AS Date), 0, N'104 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (106, N'Kashi', N'kashi.jpg', 278000, CAST(N'2023-07-17' AS Date), 1, N'102 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (108, N'Stoch Match', N'stooch-match.jpg', 474000, CAST(N'2023-07-17' AS Date), 1, N'104 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (109, N'Movado', N'movado.jpg', 56000, CAST(N'2023-07-17' AS Date), 1, N'103 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (110, N'Citizen', N'citizen.jpg', 500000, CAST(N'2023-07-17' AS Date), 1, N'103 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (111, N'Casio', N'casio.jpg', 457000, CAST(N'2023-07-17' AS Date), 1, N'104 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (113, N'Micheal Kors', N'micheal.jpg', 842000, CAST(N'2023-07-17' AS Date), 1, N'103 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (114, N'Olympia', N'olympia.jpg', 615000, CAST(N'2023-07-17' AS Date), 1, N'102 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (115, N'DW', N'dw.jpg', 570000, CAST(N'2023-07-17' AS Date), 0, N'102 ')
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [category_id]) VALUES (116, N'Guess', N'guess.jpg', 672123, CAST(N'2023-07-17' AS Date), 1, N'104 ')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'CUS', N'CUSTOMER')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'DIR', N'DIRECTOR')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'STA', N'STAFF')
GO
SET IDENTITY_INSERT [dbo].[verification_token] ON 

INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (2, N'703505', N'cuong', CAST(N'2023-08-08T19:27:44.507' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (3, N'238450', N'cuong', CAST(N'2023-08-08T20:04:35.227' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (4, N'802946', N'toan', CAST(N'2023-08-12T03:19:19.300' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (5, N'569762', N'cuong', CAST(N'2023-08-13T03:32:12.847' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (6, N'494883', N'cuong', CAST(N'2023-08-14T02:14:38.887' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (7, N'494935', N'cuong', CAST(N'2023-08-14T02:19:04.933' AS DateTime))
INSERT [dbo].[verification_token] ([id], [token], [username], [expiry_date]) VALUES (8, N'628419', N'toan', CAST(N'2023-08-14T02:22:35.643' AS DateTime))
SET IDENTITY_INSERT [dbo].[verification_token] OFF
GO
ALTER TABLE [dbo].[Authorities]  WITH CHECK ADD  CONSTRAINT [FK__Authoriti__RoleI__2B3F6F97] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Authorities] CHECK CONSTRAINT [FK__Authoriti__RoleI__2B3F6F97]
GO
ALTER TABLE [dbo].[Authorities]  WITH CHECK ADD  CONSTRAINT [FK__Authoriti__Usern__2A4B4B5E] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Authorities] CHECK CONSTRAINT [FK__Authoriti__Usern__2A4B4B5E]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Order__33D4B598] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK__OrderDeta__Order__33D4B598]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Produ__34C8D9D1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK__OrderDeta__Produ__34C8D9D1]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Username__30F848ED] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Username__30F848ED]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrdersStatus] FOREIGN KEY([status_id])
REFERENCES [dbo].[orders_status] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrdersStatus]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK__Products__Catego__2E1BDC42] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK__Products__Catego__2E1BDC42]
GO
ALTER TABLE [dbo].[verification_token]  WITH CHECK ADD  CONSTRAINT [FK__verificat__usern__5AEE82B9] FOREIGN KEY([username])
REFERENCES [dbo].[Accounts] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[verification_token] CHECK CONSTRAINT [FK__verificat__usern__5AEE82B9]
GO
USE [master]
GO
ALTER DATABASE [SonaClock] SET  READ_WRITE 
GO
