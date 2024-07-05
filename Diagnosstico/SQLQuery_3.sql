use AdventureWorks2019;

--CASE

CREATE VIEW REPORTE_PRODUCTOS 
AS 
Select ProductNumber, [name], ProductLine,
    CASE ProductLine
        when 'R' then 'ROAD'
        WHEN 'M' then 'Mountain'
        when 'T' then 'Touring'
        when 'S' then 'Other sales items'
        ELSE 'Not for sale'
    END as [category]
from Production.Product;
--where ProductLine in ('R','M');

Select*from REPORTE_PRODUCTOS;


Select ProductNumber, [name], ProductLine,
    [Category] = CASE ProductLine
        when 'R' then 'ROAD'
        WHEN 'M' then 'Mountain'
        when 'T' then 'Touring'
        when 'S' then 'Other sales items'
        ELSE 'Not for sale'
    END 
from Production.Product;

Select ProductNumber as 'Numero producto', 
[name] as 'Nombre Producto', 
[Category] = CASE productLine
        when 'R' then 'ROAD'
        WHEN 'M' then 'Mountain'
        when 'T' then 'Touring'
        when 'S' then 'Other sales items'
        ELSE 'Not for sale'
    END, ListPrice as 'Precio',
    CASE
        WHEN ListPrice =0 then 'Mfg item -not for resale'
        WHEN ListPrice < 50.0 then 'Under $50'
        when ListPrice >= 50 and ListPrice < 250 then 'Under $250'
        when ListPrice >=250.0 and ListPrice <1000 then 'Under $1000'
        ELSE 'Over $1000'
    END as [Price range]
from
Production.product;

--IS NULL (FUNCION)
Select v.AcounterNumber, v.name, 
ISNULL (v.PurchasingWebServiceURL, 'NO URL') as 'SitioWeb'
From [Purshing].[verdor] as v

--IIF 
Select  IIF(1=1, 'Verdadero', 'Falso') as 'Resultado'

SELECT IIF(LEN ('SQL Server')=10, 'OK', 'NO OK') as 'Resultado'
--"LEN": Muestra cuantos caracteres tiene una cadena

SELECT e.LoginID, e.JobTitle, e.Gender IIF( e.Gender = 'M', 'Hombre', 'Mujer') as 'Genero'
FROM humanResources.Employee as e


--select OBJECT_ID(N'tempdb..#StudentsC1')  

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

SELECT * from #StudentsC1
------------------------------------------------------------------------------

IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC2
SELECT * from #StudentsC1

insert into #StudentsC2
select s1.StudentID, s1.StudentName, s1.StudentStatus 
from #StudentsC1 S1
LEFT join #StudentsC2 S2
ON S1.StudentID=S2.StudentID
where s2.StudentID is null

select COUNT(*) FROM #StudentsC2

select  * from #StudentsC1 as S1
inner join #StudentsC2 as s2
on s1.StudentID=s2.StudentID

update s2 
set s2.studentname=s1.studentname,
s2.StudentStatus=s1.StudentStatus
from
#StudentsC1 as S1
inner join #StudentsC2 as s2
on s1.StudentID=s2.StudentID

