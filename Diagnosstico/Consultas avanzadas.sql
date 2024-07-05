USE Northwind
--Consultas avanzadas
--Seleccionar cuantos productos tiene cada categoria

select * FROM Products

select CategoryID, COUNT(*) FROM Products

SELECT categoryid from products

SELECT * FROM Products

select CategoryID, COUNT(*) 
FROM Products
GROUP BY categoryid

select c.Categoryname, COUNT(*) as 'Numero de productos'
FROM categories as C
inner join products as p
on c.categoryid=p.CategoryID
group by CategoryName;

-- Seleccionar para mostrar todos los productos juntos con sus categorias y sus precios
select p.productname , c.Categoryname, p.UnitPrice ,COUNT(*) as 'Numero de productos'
FROM categories as C
inner join products as p
on c.categoryid=p.CategoryID
group by CategoryName,productname,UnitPrice;

-- Consultar para mostrar los nombre de los productos y los nombres de sus proveedores
SELECT p.productname, s.CompanyName
from products as p 
inner join suppliers as s
on s.supplierid=p.supplierid
GROUP BY productname, companyname

-- Seleccionar las ordenes de compra mostrando los nombres de los productos y sus importes 
SELECT od.ORDERid as 'Numero de orden',
p.ProductName as 'Nombre del producto',
(od.quantity * od.UnitPrice) as 'Importe'
FROM [order details] as od
inner join products as p
on od.productid=p.productid
WHERE (od.quantity * od.UnitPrice) <= 15000
order by 'Importe' desc
-- Mostrar las ordenes de compra y los empleados que las realizaron 
SELECT o.ORDErid as 'Numero de orden',
CONCAT(e.firstname,' ',e.lastname) as 'Nombre completo'
from orders as o
inner join employees as e
on o.EmployeeID=e.EmployeeID
where year(orderdate) in (1996,1999)
-- Seleccionar las ordenes mostrando los clientes a las que se les hicieron las cantidades vendidas y los nombres de los productos ¨
select * from Customers 

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
SELECT o.OrderID as 'Numero de orden',
o.OrderDate as 'Fecha de orden',
c.CompanyName as 'Nombre del cliente',
CONCAT(e.FirstName,' ',e.LastName) as 'Nombre del empleado'
FROM Employees as e
inner join 
orders as o 
on e.EmployeeID=o.EmployeeID
inner JOIN 
Customers as c 
on o.CustomerID=c.CustomerID;

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
SELECT p.ProductName as 'Nombre del producto',
s.CompanyName as 'Nombre del proveedor',
 p.UnitPrice 'Precio'
FROM Products as p 
INNER JOIN Suppliers as s
on p.SupplierID=s.SupplierID;

SELECT p.ProductName, s.CompanyName, P.UnitPrice
FROM (
    select SupplierID,ProductName,UnitPrice from Products
) as P
INNER JOIN Suppliers as s
on P.SupplierID=s.SupplierID

--Subconsultas
SELECT p.ProductName, s.CompanyName, P.UnitPrice
FROM (
    select SupplierID,ProductName,UnitPrice from Products
) as P
INNER JOIN (
    select  SupplierID, CompanyName from Suppliers
) as s
on P.SupplierID=s.SupplierID

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT o.OrderID 'ID del pedido',
c.CompanyName as 'Nombre del cliente',
o.OrderDate 'Fecha del pedido',
YEAR(o.OrderDate) 'Año de compra',
MONTH(o.orderdate) 'Mes de compra',
DAY(o.OrderDate) 'Dia de compra'
FROM Customers as c
inner join Orders as o
on c.CustomerID=o.CustomerID

SELECT o.OrderID 'ID del pedido',
c.CompanyName as 'Nombre del cliente',
o.OrderDate 'Fecha del pedido',
YEAR(o.OrderDate) 'Año de compra',
MONTH(o.orderdate) 'Mes de compra',
DAY(o.OrderDate) 'Dia de compra' 
FROM (
    SELECT CustomerID,CompanyName FROM Customers
) as c
inner join (
    select CustomerID,OrderDate,OrderID from Orders
) as o
on c.CustomerID=o.CustomerID
--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT CONCAT(e.FirstName,' ',e.LastName) 'Nombre del enmpleado',
e.Title 'Titulo del cargo',
t.TerritoryDescription 'Territorio' 
FROM Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID=et.EmployeeID
INNER join Territories as t
on t.TerritoryID=et.TerritoryID

--Ejercico RETO: Seleccionar todas las ordenes mostrando el empleado que la realizo, el cliente 
--al que se le vendio, el nombre de los productos, sus categorias, el precio que se vendio, 
--las unidades vendidas y el importe de enero de 1997 a febrero de 1998
SELECT o.OrderID 'Numero de orden',
    CONCAT(e.FirstName, ' ', e.LastName) 'Empleado',
    c.CompanyName 'Cliente',
    p.ProductName 'Nombre del producto',
    cat.CategoryName,
    od.UnitPrice,
    od.Quantity,
    (od.UnitPrice * od.Quantity) AS Importe,
    o.OrderDate
FROM Orders as o
inner JOIN [Order Details] od ON o.OrderID = od.OrderID
inner JOIN Employees e ON o.EmployeeID = e.EmployeeID
inner JOIN Customers c ON o.CustomerID = c.CustomerID
inner JOIN Products p ON od.ProductID = p.ProductID
inner JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE o.OrderDate BETWEEN '19970101' AND '19980228'
and cat.CategoryName in ('Beverages')
ORDER BY c.CompanyName

-- Cuanto se vendio de beverages
SELECT*FROM
Categories as c
inner JOIN Products as p
on c.CategoryID=p.CategoryID
INNER join [Order Details] as od
on od.ProductID=p.ProductID
inner join Orders as o
on o.OrderID=od.OrderID


--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.


--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.