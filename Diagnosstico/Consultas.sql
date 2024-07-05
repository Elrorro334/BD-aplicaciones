 --Consultas simples (A una sola tabla)
use Northwind;

--Seleccioanr todos los costumers
select * from Customers

--Proyeccion 
select CustomerID, CompanyName, City, Country from Customers

--Selecciona 10 registro de clientes
select top 10 CustomerID, CompanyName, City, Country from Customers

--Alias de columnia
--country as pais
--country pais
--country 'pais'
--country as 'pais'
--country as 'pais de las maravillas'
select CustomerID as 'Numero de cliente', CompanyName 'Nombre de empresa' , City 'Ciudad', Country 'Pais' from Customers

--Alias de tabla
select Customers.CustomerID, customers.CompanyName, customers.City, customers.Country from Customers 

select c.CustomerID, c.CompanyName, c.City, c.Country from Customers as c
select c.CustomerID, c.CompanyName, c.City, c.Country from Customers c

--Campo calculado
select *, (P.UnitPrice*P.UnitsInStock) as 'Costo inventario' from Products as P --Con alias de tabla y columna

select ProductName 'Nombre de producto',
UnitsInStock 'Existencia',
UnitPrice 'Precio unitario',
(P.UnitPrice*P.UnitsInStock) as 'Costo inventario'
from Products as P

--Filtrar datos
--Clausula Where y operadores relacionales
/*
<   -> Menor que
>   -> Mayor que
<=  -> Menor que
>=  -> Mayor que
<>  -> Diferente
!=  -> Diferente
=   -> Igual a
*/

select * from Customers

--Seleccionar todos los cliesntes de alemania
select* from Customers where Country= 'Germany'

--Seleccioanr todos los productos que tengan un stock mayor a 20 mostrando solamente el nombre del producto, el precio y la existencia
Select p.ProductName 'Nombre de producto',
p.UnitPrice 'Precio', 
p.UnitsInStock 'Existencia' 
from Products as p 
where UnitsInStock > 20
order by ProductName desc

--Seleccionar todos los clientes ordenados de forma ascendente por pais y dentro del pais ordenados de forma descendente por ciudad

select CompanyName,Country from Customers
select * from Customers
--Solucion
select Country,City from customers as C
where Country='Germany'
order by Country,City

--Eliminar valores repetidos en una consulta

--Seleccionar los pa�ses de clientes

select country from Customers
order by 1 asc

--Contar cuantos clientes tiene por pais

select count(country)
from customers

select count( distinct country) from Customers
order by 1 asc

--Sleccionar todos los productos donde el precio es mayor o igual a 18
select * from Products as P
where P.UnitPrice >= 18.0

select * from Products as P
where P.UnitPrice <> 18.0

--Contar ciuantos son diferentes a 18
select count(*) from Products as P
where P.UnitPrice <> 18.0

--Seleccionar todos los productos que tengan un precio
--entre 18 y 25
select * from Products as P
where P.UnitPrice  between 18 and 25

select * from Products as P
where P.UnitPrice  >= 18 and UnitPrice <= 25

--Seleccionar todos los productos que no tengan un precio
--entre 18 y 25
select * from Products as P
where not (P.UnitPrice >= 18 and P.UnitPrice<=25)

select * from Products as p
where p.UnitPrice not between 18 and 25

--Seleccionar todos los productos donde el precio sea mayor a 38 y su existencia sea mayor e igual a 22
select * from Products as P
where P.UnitPrice > 38 and P.UnitsInStock >=22

--Seleccionar todos los clientes de Alemania, Mexico y Francia
select * from Customers as C
where c.Country = 'Germany' or c.country ='France' or c.country ='Mexico'

select * from Customers as C
where c.Country in ('Germany','France','Mexico')

--Seleccionar todos los clientes que  no tengan region
select * from Customers as C
where C.Region is null

select * from Customers as C
where C.Region is not null

--Seleccionar todas las ordenes enviadas de Julio de 1996 a Abril de 1998 para los empleados Buchanan, Leverling y davolio
select * from Orders as O
where O.ShippedDate between '1996-07-01' and '1998-04-01' and EmployeeID in (5,3,1)

select * from Employees as E
inner join Orders as O
on e.EmployeeID = o.EmployeeID
where O.ShippedDate between '1996-07-01' and '1998-04-01' 
and e.LastName in ('Buchanan','Leverlin','Davolio')

select e.LastName as Empleado, o.ShippedDate as 'Fecha de entrega' from Employees as E
inner join Orders as O
on e.EmployeeID = o.EmployeeID
where O.ShippedDate between '1996-07-01' and '1998-04-01' 
and e.LastName in ('Buchanan','Leverlin','Davolio')

Select * from Orders
where ShippedDate between '1996-07-01' and '1998-04-01'
and EmployeeID in (5,3,1)

--Seleccionar solo los años de las ordenes de compra
SELECT year (OrderDate) FROM Orders

--Selecciona todas las ordenes de compra para 1996
select * FROM Orders
where YEAR(OrderDate)='1996'

select OrderID as 'Numero orden', OrderDate as 'Fecha orden', YEAR(OrderDate) as Año from Orders

SELECT orderID as 'Numero Orden', OrderDate as 'Fecha orden', 
YEAR(OrderDate) as Año from Orders
where YEAR(OrderDate)='1996'

--Seleccionar todas las ordenes de compra mostrando el numero de orden, fecha de orden, año, mes y dia de 1996 y 1998

select *,OrderID as 'Numero de Orden', OrderDate as 'Fecha de Orden' from Orders
where YEAR(OrderDate)='1996','1998'

select OrderID as 'Numero de Orden', OrderDate as 'Fecha de Orden',
YEAR(OrderDate) as Año, MONTH(OrderDate) AS 'Mes',
DAY(OrderDate) as Dia
from Orders
where YEAR(OrderDate)='1996'or year(OrderDate)='1998'

select OrderID as 'Numero de Orden', OrderDate as 'Fecha de Orden',
YEAR(OrderDate) as Año, MONTH(OrderDate) AS 'Mes',
DAY(OrderDate) as Dia
from Orders
where YEAR(OrderDate)in('1996','1998')

--SEleccionar todos los apellidos de los empleados que comiencen con D
select LastName AS Apellido from Employees
Where LastName like 'D%'

--Seleccionar todos los empleados que el apellidos comience con da
select * from Employees
Where LastName like 'Da%'

--Seleccionar todos los empleados que su apellido termine con A
select * from Employees
Where LastName like '%a'

--Seleccionar todos los empleados que su apellido contemnga la a
select * from Employees
Where LastName like '%a%'

--Sleccionar todos los empleados que su apellido no contenga la letra a
select * from Employees
Where LastName not like '%a%'

--Seleccionar todos los empleados que contengan en su apellido cualquier letra y una i
select * from Employees
Where LastName like '%_i%'

select * from Employees
Where LastName like '%__i%'

select * from Employees
Where LastName like '%i_%'

--Seleccionar todos los empleados donde su nombre contenga 3 caracteres antes de ñla palbra li, despues un caracter y finalmenyte un caracter
select * from Employees
Where LastName like '%__i_g%'

--Seleccionar los apellidos que cominecen con d o con l
select * from Employees
Where LastName like 'd%' or lastname like 'l%'

select * from Employees
Where LastName like '[dl]%'

--Seleccionar todos los empleados con su apellido comiencen con unah o unha a
select * from Employees
Where LastName like '[ha]%'

select * from Employees
Where LastName like '[sc]%'

--Selleccionar todos los empleados que en su apellido contengan una d o una l
select * from Employees
Where LastName like '%[dl]%'

--Seleccionar todos los empleados en donde su apellido contenga las letras entre la A y la F
select * from Employees
Where LastName like'%[a-f]%'

--Seleccionar cuantos empleados en su apellido contiene las letras entre la A y la F
select COUNT(*) as 'Total empleados' from Employees
Where LastName like'%[a-f]%'

--Seleccionar todos los empleados en donde sus apellidos comience con CB
select * from Employees
Where LastName like'[CB]%'

--Seleccionar todos los empleados en donde sus apellidos no comiencen con CB
select * from Employees
Where LastName like'[CB]%'

--Funciones de agregado, group by y having
/*sum
count(*) Todo
count (campo) Solo el campo seleccionado
avg()
max()
min()
*/
--Selecciona el numero total de ordenes realizadas
select count(*) as 'Total de ordenes' from Orders

select COUNT(ShipRegion) from Orders 

select * from Orders

--Selecciona el numero de paises a los que les he enviado ordenes
select COUNT(distinct ShipCountry) as 'Total de envios Paises' from Orders

--Seleccionar el total de prdenes enviadas a francia entre 1996 y 1998
SELECT COUNT(ShipCountry) as 'Ordenes enviadas' FROM Orders
WHERE ShipCountry = 'France' AND YEAR(OrderDate) BETWEEN '1996' and '1998'

SELECT COUNT(ShipCountry) as 'Ordenes enviadas' FROM Orders
WHERE ShipCountry = 'Germany' AND YEAR(OrderDate) BETWEEN '1996' and '1998'

--Seleccionar el precio minimo de mis productos
select MIN(UnitPrice) as 'Precio minimo' from Products

--Selecccionar el precio mas caro de los productos
select MAX(UnitPrice) as 'Precio minimo' from Products

--Seleccionar el nombre del producto,precio de aquel que sea mas caro
SELECT top 1 ProductName,UnitPrice FROM Products
ORDER BY UnitPrice desc

--Seleccionar el monto total de todas las ordenes
SELECT sum(UnitPrice*Quantity) as 'Total de ventas' FROM [Order Details]

--Seleccionar el total de ventas realizadas a los productos que no tienen descuento
SELECT sum(UnitPrice*Quantity) as 'Total de ventas' FROM [Order Details]
WHERE Discount=0

--Seleccionar el promedio de ventas para los productos
--Singaporean Hokkien Fried Mee y Mozzarella diGiovani (42,72)
SELECT AVG(UnitPrice*Quantity) as 'Promedio de ventas' FROM [Order Details]
where ProductID in (72-42)

--Joins
/*
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN
CROSS JOIN
*/

--Seleccionar los datos de la tablas de categorias y de Productos
SELECT* FROM Categories as C
INNER JOIN Products AS P 
ON c.CategoryID = p.CategoryID

SELECT C.CategoryName as 'Nombre categoria',
P.ProductName as 'Nombre del producto',
P.UnitPrice as 'Precio unitario',
P.UnitsInStock as 'Existencia',
(P.UnitPrice*P.UnitsInStock) AS 'Precio Inventario'
FROM Categories as C
INNER JOIN Products AS P 
ON c.CategoryID = p.CategoryID

--  Seleccionar los productos de las categorias Beverages
SELECT C.CategoryName as 'Nombre categoria',
P.ProductName as 'Nombre del producto',
P.UnitPrice as 'Precio unitario',
P.UnitsInStock as 'Existencia',
(P.UnitPrice*P.UnitsInStock) AS 'Precio Inventario'
FROM Categories as C
INNER JOIN Products AS P 
ON c.CategoryID = p.CategoryID
WHERE c.CategoryName= 'beverages'

SELECT C.CategoryName as 'Nombre categoria',
P.ProductName as 'Nombre del producto',
P.UnitPrice as 'Precio unitario',
P.UnitsInStock as 'Existencia',
(P.UnitPrice*P.UnitsInStock) AS 'Precio Inventario'
FROM Categories as C
INNER JOIN Products AS P 
ON c.CategoryID = p.CategoryID
WHERE c.CategoryName= 'beverages' and p.UnitPrice > 20

--Promedio de precios
SELECT AVG(p.UnitPrice*p.UnitsInStock) as 'Precio promedio de inventarios'
FROM Categories as C
INNER JOIN Products AS P 
ON c.CategoryID = p.CategoryID
WHERE c.CategoryName= 'beverages' and p.UnitPrice > 20

--Seleccionar el total de ventas para el cliente Chop-suey Chinese de 196 a 1998
SELECT * FROM 
