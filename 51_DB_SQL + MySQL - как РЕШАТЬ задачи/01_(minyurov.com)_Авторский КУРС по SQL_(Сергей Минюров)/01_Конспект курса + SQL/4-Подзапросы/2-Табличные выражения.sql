use Northwind
-- Табличное выражение - однократное представление
;with OrderData as (
	select o.OrderID, o.OrderDate, od.ProductID, od.UnitPrice, od.Quantity, od.UnitPrice * od.Quantity as Amount
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
)
select * from OrderData

-- Декомпозиция
;with OrderData as (
	select o.OrderID, o.OrderDate, od.ProductID, od.UnitPrice, od.Quantity, od.UnitPrice * od.Quantity as Amount
	from Orders as o
	join [Order Details] as od on o.OrderID = od.OrderID
), ProductData as (
	select p.ProductID, p.ProductName, c.CategoryID, c.CategoryName
	from Products as p
	join Categories as c on p.CategoryID = c.CategoryID
)
select * 
from OrderData
join ProductData on OrderData.ProductID = ProductData.ProductID

-- Рекурсия
;with EmplTree as
(
	-- Первый уровень
	select e.EmployeeID, e.LastName, cast('' as nvarchar(20)) as Manager, 1 as [Level]
	from Employees e
	where e.ReportsTo is null
	union all
	-- Следующие уровни
	select e.EmployeeID, e.LastName, m.LastName, m.[Level] + 1
	from Employees e
	join EmplTree as m 
		-- Связь с предыдущим уровнем
		on e.ReportsTo = m.EmployeeID
)
select * from EmplTree

;with Num as (
    select 0 AS Number2
    union all
    select Num.Number2+1
    from Num
    where Num.Number2 < 100
)
select * from Num

