USE Northwind

-- FOR XML https://msdn.microsoft.com/ru-ru/library/ms178107.aspx
-- ��� ������ xml https://msdn.microsoft.com/ru-ru/library/ms187339.aspx
-- ���������� �� ����� XQuery https://msdn.microsoft.com/ru-ru/library/ms189075.aspx
-- �������� ��������� XML https://msdn.microsoft.com/ru-ru/library/ms174405.aspx

SELECT *
FROM Orders
JOIN [Order Details] AS Details ON Orders.OrderID = Details.OrderID
FOR XML AUTO, ROOT('Sales')

DECLARE @Data AS XML

SET @Data = (SELECT *
			FROM Orders
			JOIN [Order Details] AS Details ON Orders.OrderID = Details.OrderID
			FOR XML AUTO, ROOT('Sales'))

SELECT @Data

DECLARE @Handler AS int

-- ����������� 
EXEC sp_xml_preparedocument @Handler OUTPUT, @Data;

SELECT *
FROM OPENXML (@Handler, '/Sales/Orders',1)
WITH (OrderID int, CustomerID  nchar(5), EmployeeID int);

-- ������� ������
EXEC sp_xml_removedocument @Handler;