use Northwind

select o.ShipCountry, year(OrderDate) as SalesYear, sum(od.UnitPrice * od.Quantity) as Amount
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by o.ShipCountry, year(OrderDate)

select o.ShipCountry
, sum(case year(OrderDate) when 1996 then od.UnitPrice * od.Quantity end) as [1996]
, sum(case year(OrderDate) when 1997 then od.UnitPrice * od.Quantity end) as [1997]
, sum(case year(OrderDate) when 1998 then od.UnitPrice * od.Quantity end) as [1998]
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
group by o.ShipCountry
having 
sum(case year(OrderDate) when 1996 then od.UnitPrice * od.Quantity end)
 < 
sum(case year(OrderDate) when 1997 then od.UnitPrice * od.Quantity end)
and
sum(case year(OrderDate) when 1997 then od.UnitPrice * od.Quantity end)
 < 
sum(case year(OrderDate) when 1998 then od.UnitPrice * od.Quantity end)

;with SalesData as (
	select o.ShipCountry
	, sum(case year(OrderDate) when 1996 then od.UnitPrice * od.Quantity end) as [1996]
	, sum(case year(OrderDate) when 1997 then od.UnitPrice * od.Quantity end) as [1997]
	, sum(case year(OrderDate) when 1998 then od.UnitPrice * od.Quantity end) as [1998]
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
	group by o.ShipCountry
)
select * from SalesData
where [1996] < [1997] and [1997] < [1998]
order by .ShipCountry

select distinct o2.ShipCountry
, (
	select sum(od.UnitPrice * od.Quantity)
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
	where o.ShipCountry = o2.ShipCountry and year(o.OrderDate) = 1996
) as [1996]
, (
	select sum(od.UnitPrice * od.Quantity)
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
	where o.ShipCountry = o2.ShipCountry and year(o.OrderDate) = 1997
) as [1997]
, (
	select sum(od.UnitPrice * od.Quantity)
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
	where o.ShipCountry = o2.ShipCountry and year(o.OrderDate) = 1998
) as [1998]
from Orders as o2

select sum(od.UnitPrice * od.Quantity)
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
where o.ShipCountry = 'Finland' and year(o.OrderDate) = 1996

-- PIVOT - Свертка данных из таблицы в матрицу - группировка и транспонирование

select * from
(
	select o.ShipCountry, year(o.OrderDate) as SalesYear, od.UnitPrice * od.Quantity as Amount
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
) as t
pivot (sum(Amount) for SalesYear in ([1996], [1997], [1998])) as t
where [1996] < [1997] and [1997] < [1998]

;with SalesData as (
	select o.ShipCountry, year(o.OrderDate) as SalesYear, od.UnitPrice * od.Quantity as Amount
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
)
select * 
into #PivotData
from SalesData
pivot (sum(Amount) for SalesYear in ([1996], [1997], [1998])) as t

select * from #PivotData

-- UNPIVOT - Из матрицы в таблицу (нормализация данных)
select *
from #PivotData
unpivot (Amount for SalesYear in ([1996], [1997], [1998])) as t

drop table #PivotData

/*
1. Сделать отчет по продажам по категориям и годам
2. Сделать отчет по продажам по странам и категориям
*/

select * from (
	select b.CategoryName, year(o.ShippedDate) as SalesYear, od.UnitPrice*od.Quantity as Amount
	from Orders as o
	join [order details] as od on o.OrderID = od.OrderID
	join Products as m on m.ProductID = od.ProductID
	join Categories as b on b.CategoryID = m.CategoryID) as t
pivot (sum(Amount) for SalesYear in([1996], [1997], [1998])) as t
order by CategoryName



select * from (
 select o.ShipCountry as Country, cat.CategoryName as Category, sum(od.UnitPrice * od.Quantity) as Amount
 from Products as p
 join [Order Details] as od on od.ProductID=p.ProductID
 join Orders as o on o.OrderID=od.OrderID
 join Categories as cat on cat.CategoryID=p.CategoryID
 group by cat.CategoryName, o.ShipCountry
) as t
pivot (sum(Amount) for Category in (Beverages,Condiments,Confections,[Dairy Products],[Grains/Cereals],[Meat/Poultry],Produce,Seafood)) as t
