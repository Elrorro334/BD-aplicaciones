-- Funciones de fecha

--Seleccionar los años, dias, mes y cuatrimestre
use Northwind

--Funcion que devuelve alguna parte de ella
SELECT GETDATE()

SELECT DATEPART(year,'2024-06-06') as Año,
DATEPART(month, '2024-06-06') as Mes,
datepart(quarter, '2024-06-06') 'Cuatrimestre',
DATEPART(week, '2024-06-06') 'Semanana',
DATEPART(day, '2024-06-06') 'Dia',
DATEPART(weekday, '2024-06-06') 'Dia de la semana',
DATEPART(yy,'2024-06-06') 'Año 2'

SELECT DATEPART(year,orderdate) as Año,
DATEPART(month, orderdate) as Mes,
datepart(quarter, OrderDate) 'Cuatrimestre',
DATEPART(week, orderdate) 'Semanana',
DATEPART(day, orderdate) 'Dia',
DATEPART(weekday, orderdate) 'Dia de la semana',
DATEPART(yy,orderdate) 'Año 2'
from orders

--Funcion quye regresa el nombre de un mes o dia etc

SELECT DATENAME(month, GETDATE()) 'Mes'

set LANGUAGE spanish--Cambio de lenguaje

SELECT DATENAME(month, GETDATE()) 'Mes',DATENAME(weekday,GETDATE())'Dia'

SELECT DATENAME(year,orderdate) as Año,
DATENAME(month, orderdate) as Mes,
DATENAME(quarter, OrderDate) 'Cuatrimestre',
DATENAME(week, orderdate) 'Semanana',
DATENAME(day, orderdate) 'Dia',DATENAME(weekday, orderdate) 'Dia de la semana',
DATENAME(yy,orderdate) 'Año 2'
from orders

--Funcion para obtener la diferencia entre años, mese, dias etc
select DATEDIFF(year,'1983-04-06',GETDATE()) 'Tiempo de vejes'

--Seleccionar el numero de dias transcurridos entre la fecha del pedido y la fecha de entrega
SELECT OrderID,OrderDate,DATEDIFF(day,ORDERdate, shippeddate) 'Dias transcurridos'FROM Orders

