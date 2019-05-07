use Northwind

-- Многоуровневая группировка
-- Детальная аналитика по странам, городам и заказам
select o.ShipCountry, o.ShipCity, o.OrderID, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by o.ShipCountry, o.ShipCity, o.OrderID
union all
select o.ShipCountry, o.ShipCity, null, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by o.ShipCountry, o.ShipCity
union all
select o.ShipCountry, null, null, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by o.ShipCountry
union all
select null, null, null, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
order by 1,2,3

-- Сокращенная запись многоуровневой (иерархической) группировки
select o.ShipCountry, o.ShipCity, o.OrderID, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by rollup (o.ShipCountry, o.ShipCity, o.OrderID)
order by 1,2,3

-- Многомерная группировка для независимых аналитик (комбинаторика)
select o.ShipCountry, od.ProductID, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by cube(o.ShipCountry, od.ProductID)
order by 1,2 desc

-- Произвольная группировка
select 
-- Иерархическая аналитика по территориям
o.ShipCountry, o.ShipCity 
-- Иерархическая аналитика по товарам
, c.CategoryName, p.ProductName
, sum(od.Quantity) as Quantity
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
join Products as p on od.ProductID = p.ProductID
join Categories as c on p.CategoryID = c.CategoryID
group by grouping sets(
	(o.ShipCountry),
	(o.ShipCountry, o.ShipCity),
	(c.CategoryName),
	(c.CategoryName, p.ProductName),
	() -- Итоговый показатель
)
order by 1,2,3,4

/*
1. Сделать многоуровневую группировку по товарам: категория, товар, заказ, кол-во и сумма
*/
select c.CategoryName, p.ProductName, od.OrderID, 
sum(od.Quantity) as Quantity, sum(od.UnitPrice * od.Quantity) as Amount
from [Order Details] as od
join Products as p on p.ProductID = od.ProductID
join Categories as c on p.CategoryID = c.CategoryID
group by rollup (c.CategoryName, p.ProductName, od.OrderID) 
order by 1, 2 ,3
