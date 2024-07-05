create database repasojoin;

 

create table proovedor(
    provid int not null identity(1,1),
    nombre varchar (50) not null,
    limite_credito money not null,
    constraint pk_proovedor
    primary key (provid)
);

create table producto(
    prodid int not null IDENTITY (1,1),
    nombre varchar (100) not null,
    existencia int not null,
    precio money not null,
    proveedor int ,
    CONSTRAINT pk_producto
    PRIMARY KEY (prodid),
    CONSTRAINT fk_producto_proveedor
    FOREIGN key (proveedor)
    REFERENCES proovedor(provid)
);

--Insertar datos en la tabla
insert into proovedor(nombre,limite_credito)
VALUES ('proveedor1', 100000),
       ('proveedor2', 200000),
       ('proveedor3', 300000),
       ('proveedor4', 400000),
       ('proveedor5', 500000);

INSERT into producto(nombre,existencia,precio,proveedor)
values ('producto1',34,45.6,1),
       ('producto2',34,45.6,1),
       ('producto3',34,45.6,2),
       ('producto4',34,45.6,3);

select*from proovedor

SELECT*from producto

--Consultas inner join
--Seleccionar todos los productos que tiene proveedor
SELECT pr.nombre as 'Nombre de producto', pr.precio 'Precio', pr.existencia 'Existencia', p.nombre 'Proveedor'
from proovedor as p
inner join producto as pr
on p.provid=pr.proveedor

--Consulta left join 
--Mostrar todos lo proveedores y sus respectivos productos
SELECT pr.prodid,pr.nombre as 'Nombre de producto', pr.precio 'Precio', pr.existencia 'Existencia', p.nombre 'Proveedor'
from proovedor as p
left join producto as pr
on p.provid=pr.proveedor

--Utilizando Rigth join
SELECT pr.prodid,pr.nombre as 'Nombre de producto', pr.precio 'Precio', pr.existencia 'Existencia', p.nombre 'Proveedor'
from proovedor as p
RIGHT join producto as pr
on p.provid=pr.proveedor

insert into producto(nombre,precio,existencia,proveedor)
values ('producto5',78.8,22,null)

--full join
SELECT pr.prodid,pr.nombre as 'Nombre de producto', pr.precio 'Precio', pr.existencia 'Existencia', p.nombre 'Proveedor'
from proovedor as p
full join producto as pr
on p.provid=pr.proveedor

--Seleccionar todos los proveedores que no tienen asignado productos
SELECT p.provid 'Numero de Proveedor',p.nombre 'Proveedor'
from proovedor as p
LEFT join producto as pr
on p.provid=pr.proveedor
where pr.prodid is null;

--Seleccionar todos los productos que no tienen proveedor
SELECT *
from producto as pr
RIGHT join proovedor as p
on p.provid=pr.proveedor
where pr.prodid is null;