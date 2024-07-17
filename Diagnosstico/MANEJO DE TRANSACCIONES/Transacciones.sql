------Las transacciones son fundamentales paara asegurar la consistencia y la integridad de los datos
----Transaccion: Es una unidad de trabajo que se ejecuta de manera completamente existosa o no se ejecuta en absoluto.

--BEGIN TRANSACTION: Inicia una nueva transaccion 
--COMMIT TRANSACTION: Confirma todos lo cambios realizados durante la transaccion
--ROLLBACK TRANSACTION: Revierte todos los cambios realizados durante la transaccion

USE Northwind;

SELECT * FROM Categories

BEGIN TRANSACTION 

INSERT INTO Categories (CategoryName, [Description])
values ('Categoria11', 'Los Remediales')

ROLLBACK TRANSACTION

COMMIT TRANSACTION 

