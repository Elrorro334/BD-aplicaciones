--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... �- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

CREATE DATABASE Escuelita;

GO

use Escuelita

CREATE TABLE StudentsC1 (
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
GO

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sof�a Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
GO
CREATE TABLE StudentsC2 (
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
GO
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rend�n',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sof�a Mora R�os',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto Garc�a Morales',1)

SELECT * FROM StudentsC1

SELECT * FROM StudentsC2

delete StudentsC2

Select * from StudentsC1 as C1
LEFT JOIN StudentsC2 as C2
on C1.Studentid = c2.studentid
WHERE C2.StudentID IS NULL;

SELECT * FROM 
StudentsC1 as c1
inner join StudentsC2 as C2
on c1.StudentID = c2.StudentID

--CREAR UN SP QUE INSERTE Y ACTUALICE LA TABLA STUDENTC2 MEDIANTE LOS DATOS DE STUDENTC1 UTILIZANDO 
--CONSULTAS LEFT JOIN E INNER JOIN 
GO
CREATE OR ALTER PROCEDURE spu_carga_incremental_Students
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
	--Se insertan estudiantes nuevos 
		INSERT INTO StudentsC2 (StudentID,StudentName,StudentStatus)
		Select c1.StudentID,c1.StudentName, c1.StudentStatus from StudentsC1 as C1
		LEFT JOIN StudentsC2 as C2
		on C1.Studentid = c2.studentid
		WHERE C2.StudentID IS NULL;

		--Se actualizan los datos diferentes que hayan cambiado en Student1
		UPDATE C2
		SET C2.StudentName = C1.StudentName,
		C2.StudentStatus = C1.StudentStatus
		FROM 
		StudentsC1 as c1
		inner join StudentsC2 as C2
		on c1.StudentID = c2.StudentID;
		
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @mensajeError nvarchar (max)
	SET @mensajeError = ERROR_MESSAGE()
	PRINT @mensajeError
	END CATCH;
end
GO

Exec spu_carga_incremental_Students

TRUNCATE TABLE StudentsC1
TRUNCATE TABLE StudentsC2

--CREAR UN SP QUE INSERTE Y ACTUALICE LA TABLA STUDENTC2 MEDIANTE LOS DATOS DE STUDENTC1 UTILIZANDO 
--un merge 

GO
CREATE OR ALTER PROCEDURE spu_carga_incremental_Students_merge
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		MERGE INTO StudentsC2 as tgt
		USING (Select StudentID,StudentName, StudentStatus 
		from StudentsC1
		) AS src 
		ON (tgt.StudentId=src.StudentId)--For Update
		WHEN MATCHED THEN  
		 UPDATE 
		 SET tgt.StudentName = src.StudentName,
			 tgt.StudentStatus = src.StudentStatus
		--For insert
		WHEN NOT MATCHED THEN
		INSERT (StudentID,StudentName,StudentStatus)
		values (src.StudentId, src.StudentName, src.StudentStatus);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @mensajeError nvarchar (max)
	SET @mensajeError = ERROR_MESSAGE()
	PRINT @mensajeError
	END CATCH;
end;
GO

EXEC spu_carga_incremental_Students_merge 

Insert into StudentsC1
values (6,'Yañez',1)