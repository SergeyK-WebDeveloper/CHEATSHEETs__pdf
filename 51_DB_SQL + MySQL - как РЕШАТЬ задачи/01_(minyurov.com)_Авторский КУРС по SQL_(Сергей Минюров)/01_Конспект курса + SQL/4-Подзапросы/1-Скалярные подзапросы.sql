use Northwind

select max(OrderId) from Orders
-- 11077
select *
from [Order Details]
where OrderId = 11077

select *
from [Order Details]
where OrderId = (
	-- Скалярный подзапрос: одна колонка и одна строка
	select max(OrderId) from Orders
)

select *
from Orders
where CustomerID in (
	select CustomerID from Customers where Country = 'USA'
)

select *
from Orders
where CustomerID = ANY /* SOME */(
	select CustomerID from Customers where Country = 'USA'
)


select *
from Products 
where UnitPrice >= ANY (
	select max(UnitPrice)
	from Products
	group by CategoryID
)

select *
from [Order Details]
where Quantity > all (
	select avg(Quantity)
	from [Order Details]
	group by OrderId
)

select *
from [Order Details]
where Quantity > any (
	select sum(Quantity)
	from [Order Details]
	group by OrderId
)

-- Последние заказы по каждому сотруднику
select EmployeeID, max(OrderID) LastOrderId
from Orders
group by EmployeeID

select max(OrderID)
from Orders
where Orders.EmployeeID = 2

select LastName
, (select max(OrderID)
   from Orders
   -- Соединение запросов (корреляция)
   where Orders.EmployeeID = Employees.EmployeeID
) as LastOrderId
-- Для каждой строки выполняется подзапрос
from Employees

-- Алиасы таблиц
-- Найти последние заказы для каждого сотрудника
select o.EmployeeID, o.OrderID
from Orders as o
where OrderID = (
	select max(OrderID)
	from Orders as o2
   -- Соединение запросов (корреляция)
	where o.EmployeeID = o2.EmployeeID
)
-- Клиенты без заказов
select c.*
from Customers as c
where 0 = (
	select count(*)
	from Orders as o
   -- Соединение запросов (корреляция)
	where c.CustomerID = o.CustomerID 
)
-- Тест
select *
from Orders
where CustomerID in ('FISSA', 'PARIS')

select c.*
from Customers as c
-- Проверяем, что подзапрос вернул данные
where not exists (
	select *
	from Orders as o
   -- Соединение запросов (корреляция)
	where c.CustomerID = o.CustomerID 
)

/*
1. В каких месяцах были максимальное количество заказов в каждом году
2. Рейтинг продаж по заказчикам с годом, в котором были максимальное количество заказов и количество заказов за этот год
3. Рейтинг продаж по странам поставки c годом, в котором были максимальное количество заказов и количество заказов за этот год
4. Заказы с максимальной суммой продаж по каждому товару: название товара, номер заказа с максимальной суммой продаж этого товара
*/
select distinct year(OrderDate) as [Year]
, (
	select top 1 month(OrderDate) as MaxSalesMonth
	from Orders as o2
	where year(o2.OrderDate) = year(o.OrderDate)
	group by month(OrderDate)
	order by count(*) desc
) MaxSalesMonth
from Orders as o
-- Базовое решение
select top 1 month(OrderDate) as MaxSalesMonth
from Orders as o2
where year(o2.OrderDate) = 1998
group by month(OrderDate)
order by count(*) desc

--2. Рейтинг продаж по заказчикам с годом, в котором были максимальное количество заказов и количество заказов за этот год
select 
 CustomerID,
 Year(OrderDate) AS MaxYear,
 Count(*) AS OrderQty
from Orders AS OrdersOut
where Year(OrderDate) = (Select TOP (1) Year(OrderDate)
     from Orders AS OrdersIn
     where OrdersIn.CustomerID = OrdersOut.CustomerID
     group by Year(OrderDate) 
     order by count(*) desc)
group by CustomerID,Year(OrderDate)
