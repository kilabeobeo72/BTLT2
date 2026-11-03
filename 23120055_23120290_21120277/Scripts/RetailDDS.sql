-- SQL Server DDS đích: 3 Dimension + 1 Fact
IF DB_ID('Retail_DDS') IS NULL CREATE DATABASE Retail_DDS;
GO
USE Retail_DDS;
GO
CREATE TABLE dbo.DimDate (
 DateKey int NOT NULL PRIMARY KEY, FullDate date NOT NULL UNIQUE,
 [Month] tinyint NOT NULL, [Quarter] tinyint NOT NULL, [Year] smallint NOT NULL
);
CREATE TABLE dbo.DimCustomer (
 CustomerKey int IDENTITY(1,1) PRIMARY KEY,
 CustomerCode varchar(10) NOT NULL UNIQUE,
 CustomerName nvarchar(100) NOT NULL,
 City nvarchar(50) NULL
);
CREATE TABLE dbo.DimProduct (
 ProductKey int IDENTITY(1,1) PRIMARY KEY,
 ProductCode varchar(10) NOT NULL UNIQUE,
 ProductName nvarchar(100) NOT NULL,
 Category nvarchar(50) NULL
);
CREATE TABLE dbo.FactSales (
 SalesKey bigint IDENTITY(1,1) PRIMARY KEY,
 TransactionNo varchar(20) NOT NULL,
 DateKey int NOT NULL REFERENCES dbo.DimDate(DateKey),
 CustomerKey int NOT NULL REFERENCES dbo.DimCustomer(CustomerKey),
 ProductKey int NOT NULL REFERENCES dbo.DimProduct(ProductKey),
 SourceSystem varchar(10) NOT NULL,
 Quantity int NOT NULL CHECK (Quantity > 0),
 UnitPrice decimal(18,2) NOT NULL CHECK (UnitPrice >= 0),
 GrossAmount decimal(18,2) NOT NULL,
 DiscountAmount decimal(18,2) NOT NULL,
 NetAmount decimal(18,2) NOT NULL,
 CONSTRAINT UQ_FactSales_TransactionNo UNIQUE(TransactionNo)
);
CREATE TABLE dbo.ETL_RejectedRows (
 RejectKey bigint IDENTITY(1,1) PRIMARY KEY,
 SourceSystem varchar(10), TransactionNo varchar(20),
 RejectReason nvarchar(300), RejectedAt datetime2 DEFAULT sysdatetime()
);
