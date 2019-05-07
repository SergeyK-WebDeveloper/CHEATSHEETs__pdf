USE Northwind

-- Наблюдение и настройка производительности https://msdn.microsoft.com/ru-ru/library/ms189081.aspx
-- SET STATISTICS IO https://msdn.microsoft.com/ru-ru/library/ms184361.aspx
-- SET STATISTICS TIME https://msdn.microsoft.com/ru-ru/library/ms190287.aspx

SELECT *
FROM Orders	o											--  157085
JOIN [Order Details] AS od ON o.OrderID = od.OrderID	--  452627
JOIN [Customers] AS c ON o.CustomerID = c.CustomerID	--  980846
JOIN Products AS p ON od.ProductID = p.ProductID		-- 1195256
JOIN Categories AS ca ON p.CategoryID = ca.CategoryID	-- 2471776
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID		-- 2532684

SET STATISTICS IO ON
SET STATISTICS TIME ON

-- 344195
SELECT o.OrderID, o.OrderDate, od.Quantity, od.UnitPrice, c.CompanyName, p.ProductName, ca.CategoryName, s.CompanyName AS SupplierName
FROM Orders	o											
JOIN [Order Details] AS od ON o.OrderID = od.OrderID	
JOIN [Customers] AS c ON o.CustomerID = c.CustomerID	
JOIN Products AS p ON od.ProductID = p.ProductID		
JOIN Categories AS ca ON p.CategoryID = ca.CategoryID	
JOIN Suppliers AS s ON p.SupplierID = s.SupplierID

SET STATISTICS IO OFF
SET STATISTICS TIME OFF

-- Сравнение и анализ плана выполнения

-- Демонстрация SQL Server Profiler
-- https://msdn.microsoft.com/ru-ru/library/ms181091.aspx

-- Сортировка как тяжелая операция
SELECT *
FROM Orders

SELECT *
FROM Orders
ORDER BY ShipCountry
