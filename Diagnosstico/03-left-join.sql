--Crear base de datos para demostrar el uso del left join
create Database pruebajoins;
--Usamos la base de datos
use pruebajoins;
--Crear tabla categorias

Create table categorias
(
    categoriaID int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null default 'No categoria',
    CONSTRAINT pk_categoria
primary KEY(categoriaID)
);
--Crear tabla producto
create table producto
(
    productID int not null IDENTITY(1,1),
    nombre varchar (50) not null,
    existencia int not null,
    precio money not null,
    categoriaID int,
    constraint pk_producto
    PRIMARY KEY(productID),
    CONSTRAINT unico_nombre
    UNIQUE (nombre),
    constraint fk_producto_categorias
    foreign key (categoriaID)
    REFERENCES categorias(categoriaID)
);

--Agregar registros a la tabla categoria
insert into categorias(nombre)
values('LB'),
      ('Lacteos'),
      ('Ropa'),
      ('Bebidas'),
      ('Carnes frias')

--Agregar registros en la tabla productos

INSERT INTO producto(nombre,existencia,precio,categoriaID)
VALUES ('Refrigerador',3,1000.0,1),
       ('Estufa',3,9000.04,1),
       ('Crema',2,10.5,2),
       ('Yogurth',3,13.45,2);

SELECT * FROM producto

SELECT * 
FROM producto as P
INNER JOIN categorias as c
on p.categoriaID=c.categoriaID

--consulta usando un left join
SELECT * 
FROM categorias as c
left JOIN producto as p
on p.categoriaID=c.categoriaID;

--Seleccionar todas las categorias que no tienen asignado productos
SELECT c.categoriaID, c.nombre
FROM categorias as c
LEFT JOIN producto as p
on p.categoriaID=c.categoriaID
WHERE p.productID is null

--EJERCICIO

--1.-Crear una base de datos llamada ejerciciojoins
create database ejerciciojoins;
use ejerciciojoins

--2.-Crear una tabla empleados tomando como base la tabla employees de Northwind(No tomar todos los campos)
SELECT*from Northwind.dbo.employees

SELECT top 0 employeeid 'Empleado ID',
    CONCAT(firstname,' ',lastname) 'Nombre completo',
    title 'Titulo',
    hiredate 'Fecha de contratacion'
into ejerciciojoins.dbo.empleados
from Northwind.dbo.employees

select * from ejerciciojoins.dbo.empleados

--3.-Llenar la tabla con una cosnulta a la tabla employees
insert into ejerciciojoins.dbo.empleados ([Nombre completo],Titulo,[Fecha de contratacion])
SELECT 
    CONCAT(firstname,' ',lastname) 'Nombre completo',
    title 'Titulo',
    hiredate 'Fecha de contratacion'
from Northwind.dbo.employees

select top 0 *
into ejerciciojoins.dbo.dim_empleados
from ejerciciojoins.dbo.empleados

select* from empleados

--4.-Agregar nuevos datos a la tabla empleados por lo menos 2




--5.-Actualizar la tabla empleados con los nuevos registros, la cual se llenaran en una nueva tabla llamada dim_producto