Create or alter proc consulta
@Tabla nvarchar(128)
AS
BEGIN
SELECT * FROM [@Tabla]
where [tabla]=@tabla
end
go

exec consulta @Tabla=Employees

--Resultado final
GO
CREATE OR ALTER PROC tablas
@Tabla VARCHAR(50)
AS
BEGIN
DECLARE @Query nvarchar(50)
set @query = 'select * from ' + QUOTENAME (@tabla);
exec sp_executesql @query
END;

EXEC tablas products

