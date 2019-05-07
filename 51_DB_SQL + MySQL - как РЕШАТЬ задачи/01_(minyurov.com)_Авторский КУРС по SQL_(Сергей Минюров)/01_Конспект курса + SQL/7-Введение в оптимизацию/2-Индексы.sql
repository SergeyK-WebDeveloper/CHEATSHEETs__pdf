USE Northwind

-- �������� � ������������� ��������
-- CREATE INDEX https://msdn.microsoft.com/ru-ru/library/ms188783.aspx
-- �������. �������� �� ��������� ���� ���� https://msdn.microsoft.com/ru-ru/library/ms166575.aspx

-- ��������� ������������� �� ����� ���������� �� �������� ������� � �����
-- ����� �������� ������� ��������� ����� ��� ������ ��� ������������� �������� ��

-- ������ ������� �����������: ������������

-- ����������� ����������� � ����������� � ������������ ����� �������� �� ������ ��, � �� ������������ ��������� ���������� ������ �������

SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 8

SELECT *
FROM Orders
WHERE OrderDate >= '19960801' AND OrderDate < '19960901'

SELECT OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 8

SELECT OrderID, OrderDate, CustomerID, EmployeeID
FROM Orders
WHERE OrderDate >= '19960801' AND OrderDate < '19960901'

/*
CREATE NONCLUSTERED INDEX idx_Orders_OrderDate ON dbo.Orders(OrderDate, CustomerID, EmployeeID)
DROP INDEX idx_Orders_OrderDate ON dbo.Orders
*/