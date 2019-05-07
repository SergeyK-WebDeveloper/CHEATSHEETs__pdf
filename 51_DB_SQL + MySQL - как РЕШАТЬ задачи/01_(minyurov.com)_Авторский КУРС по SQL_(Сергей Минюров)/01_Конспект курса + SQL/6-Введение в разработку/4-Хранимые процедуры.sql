USE Northwind
GO

-- CREATE PROCEDURE https://msdn.microsoft.com/ru-ru/library/ms187926.aspx
CREATE PROCEDURE usp_ReadOrderByPage(@PageNo AS INT, @PageSize AS INT) AS
BEGIN
	SELECT *
	FROM Orders
	ORDER BY OrderID
	OFFSET (@PageNo - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY
END

EXEC usp_ReadOrderByPage 1, 10
EXEC usp_ReadOrderByPage 2, 10

-- Считать товарный остаток при создании заказа
GO
CREATE PROCEDURE usp_CreateOrderDetails(@OrderID AS INT, @ProductID AS INT, @Quantity AS INT, @Discount AS REAL) AS
BEGIN
	SET NOCOUNT ON; -- Не отправлять служебные сообщения клиентскому приложению

	BEGIN TRANSACTION 
		-- Данные до изменения
		--SELECT * FROM Products WHERE ProductID = @ProductID

		UPDATE Products
		SET UnitsInStock -= @Quantity, UnitsOnOrder += @Quantity
		WHERE ProductID = @ProductID

		-- Данные после изменения
		--SELECT * FROM Products WHERE ProductID = @ProductID

		INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
		--OUTPUT INSERTED.*
		SELECT @OrderID, @ProductID, UnitPrice, @Quantity, @Discount
		FROM Products
		WHERE ProductID = @ProductID
	COMMIT
END
GO

EXEC usp_CreateOrderDetails 10300, 1, 5, 0