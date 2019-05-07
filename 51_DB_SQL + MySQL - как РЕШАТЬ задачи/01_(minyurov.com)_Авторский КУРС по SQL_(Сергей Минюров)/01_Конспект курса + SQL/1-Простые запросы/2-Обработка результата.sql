use Northwind

select EmployeeID, LastName + ' ' + FirstName as FullName -- Алиас колонки (псевдоним)
--select EmployeeID, LastName + ' ' + FirstName FullName
--select EmployeeID
--     , FullName = LastName + ' ' + FirstName
--select EmployeeID, LastName + ' ' + FirstName as [Full Name]
--select EmployeeID, LastName + ' ' + FirstName as "Full Name"
--select EmployeeID, LastName + ' ' + FirstName as 'Full Name'
from Employees

select *--, UnitPrice * Quantity * (1 - Discount) as Amount
from [Order Details]
where UnitPrice * Quantity * (1 - Discount) > 1000

-- Обертка - обход синтаксических ограничений
select t.* from (
	select *, UnitPrice * Quantity * (1 - Discount) as Amount
	from [Order Details]
) as t
where Amount > 1000

-- Справочник городов, в которые были продажи
select distinct ShipCountry, ShipCity -- Другое множество данных!!!
from Orders


