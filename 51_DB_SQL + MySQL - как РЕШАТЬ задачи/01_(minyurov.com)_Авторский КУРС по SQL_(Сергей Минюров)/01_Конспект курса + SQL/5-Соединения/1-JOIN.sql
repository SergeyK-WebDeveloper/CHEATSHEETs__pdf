select * from Orders
select * from Employees

select OrderId, EmployeeID
, (select LastName from Employees as e 
   where e.EmployeeID = o.EmployeeID) as LastName
, (select FirstName from Employees as e 
   where e.EmployeeID = o.EmployeeID) as FirstName
from Orders as o

select o.OrderId, od.ProductID, e.LastName, e.FirstName, c.CompanyName, od.UnitPrice * od.Quantity as Amount
from Orders as o
inner join Employees as e 
    -- Предикат соединения
	on o.EmployeeID = e.EmployeeID
inner join Customers as c
	on o.CustomerID = c.CustomerID
inner join [Order Details] as od
	on o.OrderID = od.OrderID

-- Заказчики без заказов
select c.*
from Customers as c
left outer join Orders as o 
    -- Предикат соединения
	on c.CustomerID = o.CustomerID
where o.OrderID is null

select *
from Customers as c
where not exists (
	select top 1 o.OrderID
	from Orders as o
    -- Предикат соединения
	where c.CustomerID = o.CustomerID
)

select c.*
from Orders as o 
right outer join Customers as c
    -- Предикат соединения
	on c.CustomerID = o.CustomerID
where o.OrderID is null

-- Сокращения
-- JOIN по умолчанию INNER
-- OUTER не обязательный

-- Функциональное соединение (по значению)
select * from Territories
-- Общие значения
select distinct o.ShipCity, t.TerritoryDescription
from Orders as o
join Territories as t on o.ShipCity = t.TerritoryDescription

select distinct o.ShipCity, t.TerritoryDescription
from Orders as o
left join Territories as t on o.ShipCity = t.TerritoryDescription

select distinct o.ShipCity, t.TerritoryDescription
from Orders as o
right join Territories as t on o.ShipCity = t.TerritoryDescription

select distinct o.ShipCity, t.TerritoryDescription
from Orders as o
full outer join Territories as t on o.ShipCity = t.TerritoryDescription

select distinct o.ShipCity, t.TerritoryDescription
from Orders as o
join Territories as t on o.ShipCity <> t.TerritoryDescription

-- Декартово произведение
select e1.LastName, e2.LastName
from Employees as e1 cross join Employees as e2
-- Старый стиль
select *
from Orders as o, [Order Details] as od
where o.OrderID = od.OrderID

select *
from Orders as o, [Order Details] as od

-- Рефлексивное соединение
select e.LastName, m.LastName as Manager
from Employees as e
left join Employees as m on e.ReportsTo = m.EmployeeID


select EmployeeID, ReportsTo
from Employees

/*
1. Вывести идентификатор и дату заказа, название заказчика и фамилию продавца
2. Вывести список проданных (по которым были продажи) товаров с названием и категорией
3. Количество дней между заказами для каждого заказчика
*/
select orderid, OrderDate, c.CompanyName, e.LastName
from Orders as o
left join Customers as c on o.CustomerID = c.CustomerID
left join Employees as e on o.EmployeeID = e.EmployeeID

select distinct p.ProductName,c.CategoryName
from [Order Details] as od
join Products as p on od.ProductID = p.ProductID
left join Categories as c on p.CategoryID =c.CategoryID
--where not p.UnitsOnOrder = 0

--3. Количество дней между заказами для каждого заказчика
select o.OrderId, o.CustomerID, o.OrderDate, min(o2.OrderDate) as NextDate
from Orders as o
left join Orders as o2 on o.CustomerID = o2.CustomerID and o.OrderDate < o2.OrderDate
group by o.OrderId, o.CustomerID, o.OrderDate
order by o.CustomerID, o.OrderDate
-- "грязные" данные
select o.OrderId, o.CustomerID, o.OrderDate, o2.OrderDate as NextDate
from Orders as o
left join Orders as o2 on o.CustomerID = o2.CustomerID /*and o.OrderDate < o2.OrderDate*/
order by o.CustomerID, o.OrderDate