create database bdVentas;
use bdVentas

create table cliente (
clienteId int not null identity(1,1),
rfc varchar(20) not null,
curp varchar(18) not null,
nombres varchar(50) not null,
Apellido1 varchar(50) not null,
Apellido2 varchar (50) not null,

constraint pk_cliente
primary key(clienteId),
constraint unico_rfc
unique (rfc),
constraint unico_curp
unique (curp)
);

create table contactoProveedor (
contactoId int not null identity (1,1),
proveedorId int not null,
nombre varchar(50) not null,
Apellido1 varchar(50) not null,
Apellido2 varchar(50) not null,
constraint  pk_contactoProveedor
primary key (contactoId)
);

create table Proveedor(
proveedorId int not null identity (1,1),
nombreEmpresa varchar(20) not null,
rfc varchar (20),
calle varchar(30)not null,
colonia varchar(50)not null,
cp int not null,
paginaWeb varchar(50),

constraint pk_Proveedor
primary key (proveedorId),
constraint unico_nombreEmpresa
unique (nombreEmpresa),
constraint unico_rfc2
unique (rfc),
);

alter table contactoProveedor
add constraint fk_contactoProveedor_proveedor
foreign key (proveedorId)
references proveedor(proveedorId);

create table empleado(
empleadoId int not null identity (1,1),
nombre varchar(50) not null,
apellido1 varchar (50) not null,
apellido2 varchar(50) not null,
rfc varchar (20) not null,
curp varchar (18) not null,
numeroexterno int,
calle varchar (50) not null,
salario money not null,
numeronomina int not null,

constraint pk_Empleado
primary key (empleadoId),
constraint unico_rfc_empleado
unique(rfc),
constraint unico_curp_empleado
unique(curp),
constraint chk_salario
check (salario>=0.0 and salario <=100000),
--check (salario between 0.1 and 100000)
constraint unico_nomina_empleado
unique (numeronomina)
);

create table telefonoProveedor(
telefonoId int not null,
proveedorId int not null,
numerodetelefono varchar(15),

constraint pk_telefono_proveedor
primary key(telefonoId,proveedorId),
constraint fk_telefonoprov_proveedor
foreign key (proveedorId)
references proveedor(proveedorId)
on delete cascade
on update cascade
);

create table producto (
numerocontrol int not null identity(1,1),
descripcion varchar(50)not null,
precio money not null,
estatus int not null,
existencia int not null,
proveedorid int not null ,
constraint pk_producto
primary key(numerocontrol),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
check(precio between 1 and 200000),
constraint chk_estatus
check(estatus=1 or estatus=0),
constraint chk_existencia
check(existencia>0),
constraint fk_producto_proveedor
foreign key (proveedorid)
references proveedor(proveedorId)
);

create table ordencompra(
numeroorden int not null identity,
fechacompra date not null,
fechaentrega date not null,
clienteid int not null,
empleadoid int not null,
constraint pk_ordencompra
primary key(numeroorden),
constraint fk_ordencompra_cliente
foreign key (clienteid)
references cliente(clienteId),
constraint fk_ordencompra_empleado
foreign key(empleadoid)
references empleado(empleadoId),
);

create table detalleCompra(
productoId int not null,
numeroorden int not null,
cantidad int not null,
preciocompra money not null,
constraint pk_detallecompra
primary key (productoId, numeroorden),
constraint fk_ordencompra_producto
foreign key(productoId)
references producto (numerocontrol),
constraint fk_ordencompra_compra
foreign key (numeroorden)
references ordencompra (numeroorden)
)