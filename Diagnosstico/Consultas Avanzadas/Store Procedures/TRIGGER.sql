--SINTAXIS de TRIGGER
--Create Trigger NOMBRETRIGGER
--on --NOMBRETABLA
--AFTER INSERT,delete,update
--as
--begin
    ------codigo
--end


CREATE DATABASE PRUEBATRIGGERG3
GO
USE PRUEBATRIGGERG3;
CREATE TABLE TABLA1(
    ID INT NOT NULL PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL
);
GO
--TRIGGERS 
--TRIGGER QUE VERIFICA EL EVENTO QUE SE EJECUTO
CREATE TRIGGER tg_Verificar_Insercion
on TABLA1
AFTER INSERT
AS
    PRINT 'SE EJECUTO EL EVENTO INSERT EN LA TABLA 1'
END;

INSERT INTO TABLA1
VALUES (1,'NOMBRE1')

--TRIGGER QUE VERIFICA EL EVENTO QUE SE EJECUTO
GO
CREATE TRIGGER tg_Verificar_delete
on TABLA1
AFTER DELETE
AS
    PRINT 'SE EJECUTO EL EVENTO DELETE EN LA TABLA 1'

DELETE TABLA1

GO
CREATE TRIGGER verificar_contenido_inserted
on TABLA1
AFTER INSERT
AS BEGIN
--VER LOS DATOS EN LA TABLA INSERTED
SELECT *FROM inserted;
END;

INSERT INTO TABLA1
VALUES 
	   (3,'NOMBRE 3'),
	   (4,'NOMBRE 4')



SELECT * FROM TABLA1;

USE Northwind;
-----------------------------------------------------
GO
CREATE OR ALTER TRIGGER verificar_inserted_categories
on categories
after insert 
AS 
BEGIN
	SELECT categoryID, categoryname, [description] FROM inserted
END;

insert into categories (categoryname,[description])
values ('Categoria nueva','Prueba Triggers');
------------------------------------------------
GO
CREATE OR ALTER TRIGGER verificar_update_categories
on categories
after update
AS 
BEGIN
	SELECT categoryID, categoryname, [description] FROM inserted;
	SELECT categoryID, categoryname, [description] FROM deleted;
END;

UPDATE categories 
SET categoryname = 'CategoriaOtra',
	[description] = 'Si esta bien'
WHERE 

ROLLBACK verificar_update_categories;

Select * from categories

DROP TRIGGER Verificar_Update__Categories
DROP TRIGGER Verificar_Update_Categories
DROP TRIGGER Verificar_Inserted__Categories

GO
CREATE OR ALTER TRIGGER Verificar_Inserted_Deleted
ON Categories
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	IF EXISTS(SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
	BEGIN
		PRINT('Existeb datos en la tabla Inserted, Se ejecuto un insert')
	END
	IF EXISTS (SELECT 1 FROM DELETED) AND NOT EXISTS (SELECT 1 FROM INSERTED)
	BEGIN
		PRINT ('EXISTEN DATOS EN LA TABLA DELETED, SE REALIZO UN DELETE')
		END
	ELSE IF EXISTS (SELECT 1 FROM DELETED) AND NOT EXISTS (SELECT 1 FROM INSERTED)
	    BEGIN
		PRINT ('EXISTEN DATOS EN LAS DOS TABLAS, SE REALIZO UN UPDATE')
	END
END;

INSERT INTO categories (categoryname, [description])
VALUES ('CATEGORIA 10', 'PIPON')


drop trigger Verificar_Inserted_Deleted


--Crear un trigger en la base de datos pruebatriggers, para que la tabla empleados, 
--este trigger debe evitar que se inserten o modifiquen salario mayores a 5000
 
 use PRUEBATRIGGERG3
 GO
 CREATE TABLE empleado
 (id INT NOT NULL PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL,
 salario MONEY NOT NULL);

 ------------------------------TRIGGER-------------------------------------
GO
 CREATE OR ALTER TRIGGER verificar_salario
 on empleado
 after insert
 as
  begin
	IF EXISTS(SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
	BEGIN
	declare @Salarionuevo money
	set @Salarionuevo = (select salario from inserted)
		IF @Salarionuevo >50000
		BEGIN
		RAISERROR ('EL SALARIO ES MAYOR A 50000 Y NO ESTA PERMITIDO',16,1);
		ROLLBACK TRANSACTION;
		END
	END
END;
