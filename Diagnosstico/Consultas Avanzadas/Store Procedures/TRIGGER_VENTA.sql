--Crear trigger que permita gestionar una venta, en la cual se debe actualizar  la existencia del Producto vendido, bajo las siguientes condiciones
--1.-Verificar si la existencia no es suficiente, cancelar la insercion.
--2.-Si es suficiente, agregar la venta y disminuir el stock del producto  
USE NORTHWIND;

GO
CREATE OR ALTER TRIGGER actualizar_existencia
ON [Order Details]
AFTER update 
AS
BEGIN
    UPDATE Products
    SET UnitsInStock = UnitsInStock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END;

GO
CREATE TRIGGER trg_AfterInsertVenta
ON Ventas
AFTER INSERT
AS
BEGIN
    DECLARE @ProductoID INT;
    DECLARE @CantidadVendida INT;
    DECLARE @ExistenciaActual INT;

    -- Obtener el ProductoID y la CantidadVendida del registro insertado
    SELECT @ProductoID = i.ProductoID, @CantidadVendida = i.CantidadVendida
    FROM inserted i;

    -- Obtener la existencia actual del producto
    SELECT @ExistenciaActual = p.Existencia
    FROM Productos p
    WHERE p.ProductoID = @ProductoID;

    -- Verificar si la existencia es suficiente
    IF @ExistenciaActual < @CantidadVendida
    BEGIN
        -- Cancelar la inserción
        ROLLBACK TRANSACTION;
        RAISERROR('No hay suficiente existencia para completar la venta.', 16, 1);
    END
    ELSE
    BEGIN
        -- Actualizar la existencia del producto
        UPDATE Productos
        SET Existencia = Existencia - @CantidadVendida
        WHERE ProductoID = @ProductoID;
    END
END;
