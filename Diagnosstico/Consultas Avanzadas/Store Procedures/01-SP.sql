declare @x INT
set @x=10
print 'El valor de x es: '+ cast(@x as VARCHAR)
if @x >=0
BEGIN
    print 'El numero es positivo'
END
ELSE
BEGIN
    PRINT 'El numero es negativo'
END
DECLARE @i as INT
set @i=1
while (@i<=10)
BEGIN
    print cast (@i as VARCHAR)
    set @i=@i+1
end


--Crear un SP
go
create PROCEDURE procedure_ciclo
as
begin
    DECLARE @i INT
    set @i=1
    while (@i<=10)
BEGIN
        print 'El primer valor es '+cast (@i as VARCHAR)
        set @i=@i+1
    end
end;

declare @ii int =1
while @ii <=2
begin
    EXEC procedure_ciclo
    set @ii=@ii+1
end

--Intento
GO
create PROCEDURE Suma
    @numero1 int ,
    @numero2 int ,
    @Resultado int OUTPUT
as
BEGIN
    SET @Resultado= @numero1 + @numero2;
END;
GO

EXECUTE Suma  @numero1=5, @numero2=10, @Resultado=@ResultadoSuma Output;

--Procedure
GO
CREATE OR ALTER PROCEDURE Suma1
    @n1 int,
    @n2 int
AS
BEGIN
    declare @suma INT
    set @suma = @n1+@n2
    print 'La suma es ' + CAST(@suma as VARCHAR)
END
GO
EXEC Suma1 40,30



