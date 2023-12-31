-- Drop the 'inventory' database if it exists
DROP DATABASE IF EXISTS [inventory];
GO

-- Create the 'inventory' database
CREATE DATABASE [inventory];
GO

USE [inventory]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[idBrand] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
	[idAddress] [int] NOT NULL,
	[idContact] [int] NOT NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[idBrand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[idCategory] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[idCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colors]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colors](
	[idColor] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_Colors] PRIMARY KEY CLUSTERED 
(
	[idColor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[idImage] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
	[path] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[idImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImagesXProducts]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImagesXProducts](
	[idImageXProducts] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [int] NOT NULL,
	[idImage] [int] NOT NULL,
 CONSTRAINT [PK_ImagesXProducts] PRIMARY KEY CLUSTERED 
(
	[idImageXProducts] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryLog]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryLog](
	[idInventoryLog] [int] IDENTITY(1,1) NOT NULL,
	[idEmployee] [int] NOT NULL,
	[idSupplier] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
	[posttime] [datetime] NOT NULL,
	[idOperationType] [int] NOT NULL,
	[transferAmount] [int] NOT NULL,
	[description] [nchar](80) NOT NULL,
	[checksum] [varbinary](150) NOT NULL,
 CONSTRAINT [PK_InventoryLog] PRIMARY KEY CLUSTERED 
(
	[idInventoryLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[idLocation] [int] NOT NULL,
	[aisle] [tinyint] NOT NULL,
	[shelf] [tinyint] NOT NULL,
	[store] [tinyint] NOT NULL,
	[section] [tinyint] IDENTITY(1,1) NOT NULL,
	[geoposition] [geography] NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[idLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Materials]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[idMaterial] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_Materials] PRIMARY KEY CLUSTERED 
(
	[idMaterial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialsXProduct]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialsXProduct](
	[idMaterialXProduct] [int] IDENTITY(1,1) NOT NULL,
	[idMaterial] [int] NOT NULL,
	[idProduct] [int] NOT NULL,
 CONSTRAINT [PK_MaterialsXProduct] PRIMARY KEY CLUSTERED 
(
	[idMaterialXProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationTypes]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationTypes](
	[idOperationType] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
 CONSTRAINT [PK_OperationTypes] PRIMARY KEY CLUSTERED 
(
	[idOperationType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[idProduct] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
	[idCategory] [int] NOT NULL,
	[description] [nchar](80) NOT NULL,
	[idLocation] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [money] NOT NULL,
	[weight] [numeric](8, 2) NOT NULL,
	[idColor] [int] NOT NULL,
	[idBrand] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductsXSuppliers]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsXSuppliers](
	[idProductXSupplier] [int] IDENTITY(1,1) NOT NULL,
	[idProduct] [int] NOT NULL,
	[idSupplier] [int] NOT NULL,
 CONSTRAINT [PK_ProductsXSuppliers] PRIMARY KEY CLUSTERED 
(
	[idProductXSupplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 11/12/2023 4:16:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[idSupplier] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL,
	[idAddress] [int] NOT NULL,
	[idContact] [int] NOT NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[idSupplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImagesXProducts]  WITH CHECK ADD  CONSTRAINT [FK_ImagesXProducts_Images] FOREIGN KEY([idImage])
REFERENCES [dbo].[Images] ([idImage])
GO
ALTER TABLE [dbo].[ImagesXProducts] CHECK CONSTRAINT [FK_ImagesXProducts_Images]
GO
ALTER TABLE [dbo].[ImagesXProducts]  WITH CHECK ADD  CONSTRAINT [FK_ImagesXProducts_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[ImagesXProducts] CHECK CONSTRAINT [FK_ImagesXProducts_Products]
GO
ALTER TABLE [dbo].[InventoryLog]  WITH CHECK ADD  CONSTRAINT [FK_InventoryLog_OperationTypes] FOREIGN KEY([idOperationType])
REFERENCES [dbo].[OperationTypes] ([idOperationType])
GO
ALTER TABLE [dbo].[InventoryLog] CHECK CONSTRAINT [FK_InventoryLog_OperationTypes]
GO
ALTER TABLE [dbo].[InventoryLog]  WITH CHECK ADD  CONSTRAINT [FK_InventoryLog_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[InventoryLog] CHECK CONSTRAINT [FK_InventoryLog_Products]
GO
ALTER TABLE [dbo].[InventoryLog]  WITH CHECK ADD  CONSTRAINT [FK_InventoryLog_Suppliers] FOREIGN KEY([idSupplier])
REFERENCES [dbo].[Suppliers] ([idSupplier])
GO
ALTER TABLE [dbo].[InventoryLog] CHECK CONSTRAINT [FK_InventoryLog_Suppliers]
GO
ALTER TABLE [dbo].[MaterialsXProduct]  WITH CHECK ADD  CONSTRAINT [FK_MaterialsXProduct_Materials] FOREIGN KEY([idMaterial])
REFERENCES [dbo].[Materials] ([idMaterial])
GO
ALTER TABLE [dbo].[MaterialsXProduct] CHECK CONSTRAINT [FK_MaterialsXProduct_Materials]
GO
ALTER TABLE [dbo].[MaterialsXProduct]  WITH CHECK ADD  CONSTRAINT [FK_MaterialsXProduct_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[MaterialsXProduct] CHECK CONSTRAINT [FK_MaterialsXProduct_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Brands] FOREIGN KEY([idBrand])
REFERENCES [dbo].[Brands] ([idBrand])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Brands]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([idCategory])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Colors] FOREIGN KEY([idColor])
REFERENCES [dbo].[Colors] ([idColor])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Colors]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Location] FOREIGN KEY([idLocation])
REFERENCES [dbo].[Location] ([idLocation])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Location]
GO
ALTER TABLE [dbo].[ProductsXSuppliers]  WITH CHECK ADD  CONSTRAINT [FK_ProductsXSuppliers_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[ProductsXSuppliers] CHECK CONSTRAINT [FK_ProductsXSuppliers_Products]
GO
ALTER TABLE [dbo].[ProductsXSuppliers]  WITH CHECK ADD  CONSTRAINT [FK_ProductsXSuppliers_Suppliers] FOREIGN KEY([idSupplier])
REFERENCES [dbo].[Suppliers] ([idSupplier])
GO
ALTER TABLE [dbo].[ProductsXSuppliers] CHECK CONSTRAINT [FK_ProductsXSuppliers_Suppliers]
GO
