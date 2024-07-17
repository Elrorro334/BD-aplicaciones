CREATE OR ALTER PROCEDURE eliminar_orden
@OrdenID INT
AS
BEGIN
    BEGIN TRANSACTION;

	BEGIN TRY
	DECLARE @ProductID INT,
	@Quantity INT;

	CREATE TABLE #OrderDetailsTemp(
		ProductID INT,
		Quantity INT
	);

	INSERT INTO #OrderDetailsTemp(ProductID,Quantity)
		SELECT ProductID, Quantity
		FROM [Order Details]
		WHERE OrderID = @OrdenID;

		UPDATE Products
		SET UnitsInStock = UnitsInStock + od.Quantity
		FROM Products p
		INNER JOIN #OrderDetailsTemp od 
		ON p.ProductID = od.ProductID;

			DELETE from [Order Details]
			WHERE OrderID = @OrdenID;

			DELETE from Orders
			WHERE OrderID = @OrdenID;

			DROP TABLE #OrderDetailsTemp;
		COMMIT TRANSACTION;		
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @mensajeError nvarchar (max)
	SET @mensajeError = ERROR_MESSAGE()
	PRINT @mensajeError
	END CATCH;

END;
GO

EXEC eliminar_orden 10250



SELECT * FROM Orders;

Select * from [Order Details] 

SELECT * FROM Products