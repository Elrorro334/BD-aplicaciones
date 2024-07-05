--Stored procedures (Parametros de salida)

--Crear SP que calcule area de un circulo
create or alter procedure sp_CalcularAreaCirculo
    @Radio FLOAT,
    --Parametro de entrada
    @Area FLOAT OUTPUT
--Parametro de salida
AS
Begin
    set @Area=PI() * @radio * @radio
END;
go

DECLARE @resultado FLOAT
exec sp_CalcularAreaCirculo @radio=22.3, @area=@resultado output;

print 'El valor del area es: ' + cast(@resultado as varchar);
go

--SP OBTNER NOMBRE Y APELLIDO DE EMPLEADO
create or alter PROCEDURE SP_ObtenerInformacionDelEmpleado
    @employeeID int = -1,
    @apellido nvarchar(20) OUTPUT,
    @nombre nvarchar(10) output
as
BEGIN

    IF @employeeID <> -1
    BEGIN
        select @nombre = FirstName, @apellido = LastName
        from Employees
        WHERE EmployeeID=@employeeID
    end
    ELSE
    BEGIN
        PRINT ('El valor del empleado no es valido')
    END

END;

DECLARE @Firstname as NVARCHAR(20),
@Lastname as NVARCHAR(10)

EXEC SP_ObtenerInformacionDelEmpleado @employeeID = 1, @nombre=@Firstname output, @apellido=@Lastname output
PRINT ('El nombre es: '+ @Firstname)
PRINT ('El apellido es: '+@lastname);

----------------------------------------------------------------------------------------------------------

DECLARE @Firstname as NVARCHAR(20),
@Lastname as NVARCHAR(10)

EXEC SP_ObtenerInformacionDelEmpleado 
@nombre=@Firstname output, 
@apellido=@Lastname output
PRINT ('El nombre es: '+ @Firstname)
PRINT ('El apellido es: '+@lastname);

----------------------------------------------------- VERIFICAR SI EL EMPLOYEEID ES VALIDO ------------------------------------------------------------------
go
CREATE OR ALTER PROCEDURE SP_Verificar_EmployeeID
    @employeeID INT = -1,
    @apellido NVARCHAR(20) OUTPUT,
    @nombre NVARCHAR(10) OUTPUT
AS
BEGIN
    DECLARE @existe INT;

    -- Verificar la existencia del EmployeeID
    SET @existe = (SELECT COUNT(*)
    FROM Employees
    WHERE EmployeeID = @employeeID);

    -- Comprobación si el EmployeeID es diferente de -1
    IF @employeeID <> -1
    BEGIN
        IF @existe > 0
        BEGIN
            SELECT @nombre = FirstName, @apellido = LastName
            FROM Employees
            WHERE EmployeeID = @employeeID;
        END
        ELSE
        BEGIN
            PRINT 'El valor del empleado no existe en la tabla';
        END
    END
    ELSE
    BEGIN
        PRINT 'Se debe introducir un valor';
    END
END;
GO

-- Declaración de variables para recibir los valores de salida
DECLARE @FirstName NVARCHAR(10),
        @LastName NVARCHAR(20);

-- Ejecución del procedimiento almacenado
EXEC SP_Verificar_EmployeeID @employeeID = 50, @nombre = @FirstName OUTPUT, @apellido = @LastName OUTPUT;

-- Impresión de los resultados
PRINT 'El nombre es: ' + @FirstName;
PRINT 'El apellido es: ' + @LastName;
--------------------------------------------- OTRA FORMA --------------------------------------------------------------------

GO
create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

-------------------------------------------------------------

declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2 @employeeid = 3,
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)

--GUARDE UNA VARIABLE DE SALIDA
GO
create or alter proc sp_ObtenerVentasPorCliente
@customerId nchar (5),
@fechainicial date, 
@fechafinal date,
@total decimal (10,2) output
as

SELECT @total = sum(od.UnitPrice * od.Quantity)
FROM [order details] AS od
inner join orders as o 
on od.orderid=o.orderid
where customerid = @customerid and 
o.OrderDate between @fechainicial and @fechafinal

EXEC sp_ObtenerVentasPorCliente 2,'1996-01-01','1997-03-04'

select * from orders
