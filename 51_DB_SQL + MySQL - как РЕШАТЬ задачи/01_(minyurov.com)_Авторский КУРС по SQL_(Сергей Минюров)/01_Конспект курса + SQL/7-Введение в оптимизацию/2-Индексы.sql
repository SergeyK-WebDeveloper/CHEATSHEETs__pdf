USE Northwind

-- Создание и использование индексов
-- CREATE INDEX https://msdn.microsoft.com/ru-ru/library/ms188783.aspx
-- Учебник. Помощник по настройке ядра СУБД https://msdn.microsoft.com/ru-ru/library/ms166575.aspx

-- Сравнение эффективности по плану выполнения до создания индекса и после
-- После создания индекса требуется время для начала его использования сервером БД

-- Первый принцип оптимизации: тестирование

-- Оптимизация заключается в минимизации и балансировке общей нагрузке на сервер БД, а не максимальном ускорении выполнения одного запроса

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