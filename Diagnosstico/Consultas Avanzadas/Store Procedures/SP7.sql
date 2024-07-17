GO

CREATE OR ALTER PROCEDURE dbo.Verificarinserciondedatos
AS
BEGIN
    BEGIN TRY
        -- Intentar insertar los datos
        INSERT INTO [dbo].[Employees] 
        (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate) 
        VALUES 
        ('Sanchez', 'Rodrigo', 'Vice President, Sales', 'Dr.', '2004-10-17', '2024-07-09');
        
        -- Verificar si se insertaron los datos
        IF @@ROWCOUNT > 0
        BEGIN
            PRINT 'Los datos se insertaron correctamente.';
        END
        ELSE
        BEGIN
            PRINT 'No se insertaron los datos.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Ocurrió un error durante la inserción de datos.';
    END CATCH
END
GO

EXEC dbo.Verificarinserciondedatos

SELECT * FROM Employees

