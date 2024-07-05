SELECT * FROM [Order Details]
SELECT * FROM Orders
SELECT * FROM Customers
--Crear Stored Procedure para checar ventas por año y cliente
GO
CREATE or ALTER PROCEDURE Ventasporclienteyaño
@AÑO INT
AS BEGIN
SELECT 
c.CompanyName AS 'Nombre Cliente',
YEAR(o.OrderDate) as 'Año',
SUM(od.Quantity * od.UnitPrice) AS 'Total Vendido'
FROM Orders as o
inner JOIN [Order Details] od 
ON o.OrderID = od.OrderID
inner JOIN Customers c 
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = @AÑO
GROUP BY c.CompanyName, YEAR(o.OrderDate)
ORDER BY 'Total Vendido' DESC;
END;

EXEC Ventasporclienteyaño @AÑO = 1998;

--Insertar producto en una tabla
GO
create or ALTER Procedure InsertarProducto
@Producto VARCHAR(50),
@ClienetID VARCHAR(50),
@CategoriaID VARCHAR(50),
@Cantidad_Unitaria VARCHAR(50),
@Precio_Unitario VARCHAR(50),
@Unidad_en_Stock VARCHAR(50),
@Units_on_order VARCHAR(50),
@Reorder_Level VARCHAR(50),
@Discontinuado VARCHAR(50)
as BEGIN
insert into Products(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
VALUES (@Producto, @ClienetID, @CategoriaID, @Cantidad_Unitaria, @Precio_Unitario, @Unidad_en_Stock, @Units_on_order, @Reorder_Level, @Discontinuado)
END;

EXEC InsertarProducto @Producto=Catsup, 
@ClienetID=2, 
@CategoriaID=1, 
@Cantidad_Unitaria=[30 boxes], 
@Precio_Unitario=20.00, 
@Unidad_en_Stock=43, 
@Units_on_order=30, 
@Reorder_Level=20, 
@Discontinuado=1;

select * from Products