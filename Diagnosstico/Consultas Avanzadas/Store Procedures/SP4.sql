CREATE OR ALTER procedure sp_ventasproveedor
@Year int,
@month int,
@day int
AS BEGIN 
select s.CompanyName,
sum(od.UnitPrice*od.Quantity) as Total
from 
Suppliers as s
inner join Products as P
on s.SupplierID=p.SupplierID
inner join [Order details] as od
on p.productID=od.ProductID
inner join Orders as o
on o.OrderID=od.OrderID
where datepart(YEAR,o.OrderDate)=@Year
and DATEPART(MONTH,o.OrderDate)=@month
and DATEPART(DAY,o.OrderDate)=@day
group by s.companyname
order by s.CompanyName;
END

exec sp_ventasproveedor @year=1996,@month=07,@day=04

--1.-Inserte o actualice los registros nuevos o los cambio en la tabla product, suppliers, customers,employees, tomando como base northwind (stored procedure)
--Para la tabla productos
CREATE PROCEDURE UpsertProduct
    @ProductID INT,
    @ProductName NVARCHAR(40),
    @SupplierID INT,
    @CategoryID INT,
    @QuantityPerUnit NVARCHAR(20),
    @UnitPrice DECIMAL(18, 2),
    @UnitsInStock SMALLINT,
    @UnitsOnOrder SMALLINT,
    @ReorderLevel SMALLINT,
    @Discontinued BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        -- Update existing record
        UPDATE Products
        SET ProductName = @ProductName,
            SupplierID = @SupplierID,
            CategoryID = @CategoryID,
            QuantityPerUnit = @QuantityPerUnit,
            UnitPrice = @UnitPrice,
            UnitsInStock = @UnitsInStock,
            UnitsOnOrder = @UnitsOnOrder,
            ReorderLevel = @ReorderLevel,
            Discontinued = @Discontinued
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        -- Insert new record
        INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
        VALUES (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued);
    END
END;
--Para la tabla Suppliers
CREATE PROCEDURE UpsertSupplier
    @SupplierID INT,
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24),
    @HomePage NVARCHAR(MAX)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Suppliers WHERE SupplierID = @SupplierID)
    BEGIN
        -- Update existing record
        UPDATE Suppliers
        SET CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax,
            HomePage = @HomePage
        WHERE SupplierID = @SupplierID;
    END
    ELSE
    BEGIN
        -- Insert new record
        INSERT INTO Suppliers (CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage)
        VALUES (@CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax, @HomePage);
    END
END;
--Para la tabla Customers
CREATE PROCEDURE UpsertCustomer
    @CustomerID NCHAR(5),
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        -- Update existing record
        UPDATE Customers
        SET CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax
        WHERE CustomerID = @CustomerID;
    END
    ELSE
    BEGIN
        -- Insert new record
        INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
        VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax);
    END
END;
--Para la tabla Employees
CREATE PROCEDURE UpsertEmployee
    @EmployeeID INT,
    @LastName NVARCHAR(20),
    @FirstName NVARCHAR(10),
    @Title NVARCHAR(30),
    @TitleOfCourtesy NVARCHAR(25),
    @BirthDate DATETIME,
    @HireDate DATETIME,
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @HomePhone NVARCHAR(24),
    @Extension NVARCHAR(4),
    @Photo VARBINARY(MAX),
    @Notes NVARCHAR(MAX),
    @ReportsTo INT,
    @PhotoPath NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
        -- Update existing record
        UPDATE Employees
        SET LastName = @LastName,
            FirstName = @FirstName,
            Title = @Title,
            TitleOfCourtesy = @TitleOfCourtesy,
            BirthDate = @BirthDate,
            HireDate = @HireDate,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            HomePhone = @HomePhone,
            Extension = @Extension,
            Photo = @Photo,
            Notes = @Notes,
            ReportsTo = @ReportsTo,
            PhotoPath = @PhotoPath
        WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        -- Insert new record
        INSERT INTO Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath)
        VALUES (@LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath);
    END
END;


--2.-Crear un SP, que actualice la tabla ventas

