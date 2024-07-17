-- Crear la base de datos AlmacenDatos
CREATE DATABASE AlmacenDatos;


-- Usar la base de datos AlmacenDatos
USE AlmacenDatos;


-- Crear la tabla Customers
CREATE TABLE Customers (
    ClienteId int identity(1,1)NOT NULL,
    Clientebk int,
    CompanyName nvarchar(30) NULL,
    Address nvarchar(60) NULL,
    City nvarchar(15) NULL,
    Region nvarchar(15) NULL,
    Country nvarchar(15) NULL,
    CONSTRAINT PK_Customers PRIMARY KEY CLUSTERED (ClienteId),
    CONSTRAINT fk_  
);


-- Crear la tabla Ventas
CREATE TABLE Ventas (
    ClienteId int identity (1,1) NOT NULL,
    ProductoId int NOT NULL,
    EmployeId int NOT NULL,
    SupplerId int NOT NULL,
    UnitPrice money NOT NULL,
    Quantity smallint NOT NULL,
    CONSTRAINT PK_Ventas PRIMARY KEY (ClienteId, ProductoId, EmployeId, SupplerId),
    CONSTRAINT FK_Ventas_Customers FOREIGN KEY (ClienteId) REFERENCES Customers(ClienteId),
    CONSTRAINT FK_Ventas_Products FOREIGN KEY (ProductoId) REFERENCES Products(ProductId),
    CONSTRAINT FK_Ventas_Employees FOREIGN KEY (EmployeId) REFERENCES Employees(EmployeeId),
    CONSTRAINT FK_Ventas_Supplier FOREIGN KEY (SupplerId) REFERENCES Supplier(ShipperId)
);
GO

-- Crear la tabla Supplier
CREATE TABLE Supplier (
    ShipperId int IDENTITY(1,1) NOT NULL,
    Shipperbk int,
    CompanyName nvarchar(40) NOT NULL,
    Country nvarchar(15) NULL,
    Address nvarchar(60) NULL,
    City nvarchar(15) NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (ShipperId)
);
GO

-- Crear la tabla Employees
CREATE TABLE Employees (
    EmployeeId int IDENTITY(1,1) NOT NULL,
    Employeebk int,
    FullName nvarchar(80) NOT NULL,
    Title nvarchar(30) NULL,
    HireDate datetime NULL,
    Address nvarchar(60) NULL,
    City nvarchar(15) NULL,
    Region nvarchar(15) NULL,
    Country nvarchar(15) NULL,
    CONSTRAINT PK_Employees PRIMARY KEY (EmployeeId)
);
GO

-- Crear la tabla Products
CREATE TABLE Products (
    ProductId int IDENTITY(1,1) NOT NULL,
    Productbk int,
    ProductName nvarchar(40) NOT NULL,
    CategoryName nvarchar(40) NOT NULL,
    CONSTRAINT PK_Products PRIMARY KEY (ProductId)
);
GO

drop table products