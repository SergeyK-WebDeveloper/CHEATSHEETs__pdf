use Northwind

select *
from Products
order by ProductName desc

select *
from Products
order by CategoryID asc, UnitPrice desc

-- Зависимость полей при DISTINCT
select distinct ProductName
from Products
order by ProductName desc


select ProductID, ProductName, UnitPrice
from Products
order by 3 desc, 2


select *, UnitPrice * Quantity as Amount
from [Order Details]
order by Amount

select *
from [Order Details]
order by UnitPrice * Quantity

-- Рейтинги
select top (10) *
from Products
order by UnitPrice desc

select top (10) percent *
from Products
order by UnitPrice desc

select top (11) with ties * -- "хвостик" - дублирование последних данных
from Products
order by UnitPrice desc

select *
from Products
order by UnitPrice desc
	offset 10 rows -- Пропускаем первые 10 записей
	fetch next 10 rows only -- Берем следующие 10 записей
