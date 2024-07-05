create database Vistaspractica

use Vistaspractica

--Crear una vista de la siguiente consulta
create VIEW  VIEW_categorias_productos 
AS

SELECT c.categoryname 'Nombre Categoria',
p.productname 'Nombre producto',
p.unitprice 'Precio',
p.unitsinstock 'Existencia'
from Northwind.dbo.Categories as c
inner join Northwind.dbo.products as P
on c.categoryID = p.categoryID;

select *,(precio*existencia) as 'Precio inventario' 
from VIEW_categorias_productos
WHERE [nombre categoria] in ('beverages', 'condiments')
order by [Nombre categoria] desc;

--Seleccionar la suma del precio del inventario agrupado por categoria
select [Nombre Categoria],
sum(Precio*existencia) as 'Suma del Precio inventario'
from VIEW_categorias_productos
group by [Nombre categoria];