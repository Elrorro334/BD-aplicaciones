use [bdVentas]

select * from Northwind.dbo.Customers --Nort(nombre de bd), dbo(esquemas), cutomers (tabla)

go
select * from cliente
go

--Insertar en la tabla cliente

insert into cliente(rfc,curp,nombres,Apellido1,Apellido2)
values ('klhg19830406x9j', 'SACR041017HMCNRDA1', 'Alfreds Futterkiste','Perez','Futterkiste'),
('jlhg19830406x9z', 'JLHG19880416', 'Ana Trujillo Emparedados y helados','Perez','Futterkiste'),
('jlhg19830406x9d', 'JLHG19880496', 'Ana Trujillo Emparedados y helados','Perez','Futterkiste'),
('jlhg19830406x9f', 'JLHG19880436', 'Ana Trujillo Emparedados y helados','Perez','Futterkiste'),
('jlhg19830406x9k', 'JLHG19880456', 'Ana Trujillo Emparedados y helados','Perez','Futterkiste');

select * from cliente

delete cliente

DBCC CHECKIDENT (cliente, RESEED,0) --Reiniciar el identity

select top 0 EmployeeID as 'EmpleadoId' ,LastName as 'Segundo Nombre',FirstName as 'Primer nombre', BirthDate as 'Fecha de nacimiento', HireDate as 'Fecha Contratacion',
[address] as 'Direccion', City as 'City', Region, PostalCode as 'Codigo Postal', Country as 'Pais'
into empleado2
from Northwind.dbo.Employees

--Insertar datos a partir de una consulta

select *  from empleado2

alter table empleado2
add constraint pk_empleado2
primary key (empleadoid)

insert into empleado2 (EmpleadoId,[Segundo Nombre],[Primer nombre],[Fecha de nacimiento],[Fecha Contratacion],Direccion,City,Region,[Codigo Postal],Pais)
select EmployeeID as 'EmpleadoId' ,LastName as 'Segundo Nombre',FirstName as 'Primer nombre', BirthDate as 'Fecha de nacimiento', HireDate as 'Fecha Contratacion',
[address] as 'Direccion', City as 'City', Region, PostalCode as 'Codigo Postal', Country as 'Pais'


select top 5* from Northwind.dbo.[Order Details]--TOP es para mostrar los primeros 5 resultados
order by OrderID desc --Ordena de ultimo a primero

select * from cliente;
select * from empleado
insert into empleado(nombre,apellido1,apellido2,curp,rfc,numeroexterno,calle,salario,numeronomina)
values('Alan','Santiago','Molina','ALM2632736','ALM82892','23','Calle del manzano',72882.9,727828),
('Yamileth','Aguirre','Rangel','YMFB872892','YAT278393','32','Calle del hambre',77338.90,728782),
('Samatha','Dominguez','Lopez','SDLK88918','SDL832908','20','Calle de la gordura',29190,839283);

insert into ordencompra
values (getDate(),'2024-06-10',1,3)
       (GETDATE(),'2024-07-11',3,4)

select * from producto

select * from Northwind.dbo.Products

select * from Proveedor
select * from Northwind.dbo.Suppliers
insert into Proveedor
select  supplierid,CompanyName,PostalCode,'Calle Soledad',city,2345 as cp,'www.prueba.com.mx' as 'pagina web'from Northwind.dbo.Suppliers

--Sellecciona la fecha actual del sistema
select getdate()
select * from ordencompra	


insert into producto(numerocontrol,descripcion,precio,[estatus],existencia,proveedorid)														
select ProductID,ProductName,UnitPrice,Discontinued,UnitsInStock,SupplierID from Northwind.dbo.Products	

select * from ordencompra
insert into detalleCompra
values (2,2,20,
(select precio from producto where numerocontrol=2))			

select * from detalleCompra
update producto
set precio = 20.2
where numerocontrol=1


