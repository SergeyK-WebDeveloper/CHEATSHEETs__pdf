use Northwind

select * from [Order Details]

select count(*) 
from [Order Details]
where Quantity > 10

select count(*) 
, sum(Quantity) As TotalQty
, max(UnitPrice) AS MaxPrice
, min(UnitPrice) as MinPrice
, avg(UnitPrice) As AvgPrice
from [Order Details]

select count(*), count(DISTINCT Title), count(Region)
from Employees

select DISTINCT Title
from Employees

select avg(UnitPrice), avg(DISTINCT UnitPrice)
from Products

select sum(case when ShipCountry = 'France' then 1 end) as France
, sum(case ShipCountry when 'Germany' then 1 end) as Germany
, sum(case ShipCountry when 'Brazil' then 1 end) as Brazil
from Orders

--select count(*)
--from Orders

select ShipCountry, count(*)
from Orders
where ShipCountry in ('France', 'Germany', 'Brazil')
group by ShipCountry

select ShipCountry--, count(*) OrderQty
from Orders
group by ShipCountry
having count(*) > 100

select ShipCountry, count(*) OrderQty
from Orders
group by ShipCountry
order by OrderQty desc
-- Ошибка - заставляем обрабатывать ненужные данные
select ShipCountry, count(*)
from Orders
group by ShipCountry
having ShipCountry in ('France', 'Germany', 'Brazil')

select Country, COUNT(*)
from Customers
group by Country
order by Country

select Country, City, COUNT(*)
from Customers
group by Country, City
order by Country

select Country, COUNT(*), min(CompanyName), max(CompanyName)
from Customers
group by Country
order by Country
-- Дизассемблирование
select Country, CompanyName
from Customers
where Country = 'Argentina'
order by CompanyName

select count(*) as LineQty 
, count(distinct OrderId) AS OrderQty
, count(distinct ProductId) AS ProductQty
from [Order Details]

select count(*) AS OrderQty
from Orders

select OrderId, ProductId, count(*) as LineQty 
, sum(Quantity) as Qty
, max(UnitPrice) as MaxPrice
, max(Discount) As MaxDiscount
from [Order Details]
group by OrderId, ProductId -- Уникальность

select Country, Phone, count(*)
from Customers
group by Country, Phone -- Уникальность

select year(OrderDate), count(*)
from Orders
group by year(OrderDate)

/* 
1. Найти по категориям товара количество (наличие) в справочнике товаров, минимальную, максимальную и среднюю цену. Упорядочить по количеству.
2. Найти месяц и год, в котором были максимальное количество заказов по продажам
3a. Посчитать кол-во заказов, которые были оформлены сотрудниками Davolio, Fuller и Leverling (без JOIN).
3b. Посчитать кол-во заказов, которые были оформлены сотрудниками Davolio, Fuller и Leverling (без JOIN) и вывести их в одной строке отдельными колонками.
*/

select CategoryID, sum(UnitsInStock),max(UnitPrice),min(UnitPrice),avg(UnitPrice)
from Products
group by CategoryID
order by sum(UnitsInStock)

/*2. Найти месяц и год, в котором были максимальное количество заказов по продажам
1. Посчитать к-во заказов по годам и месяцам
2. Упорядочение данных и ограничение
*/
select top 1 year(OrderDate), MONTH(OrderDate)
from Orders
group by year(OrderDate), MONTH(OrderDate)
order by count(*) desc


select EmployeeID, count(*)
from Orders
where EmployeeID in (1, 2 ,3)
group by EmployeeID

--3b. Посчитать кол-во заказов, которые были оформлены сотрудниками Davolio, Fuller и Leverling (без JOIN) и вывести их в одной строке отдельными колонками.
select 
 count(case EmployeeID when 1 then 1 end) as Davolio
, count(case EmployeeID when 2 then 1 end) as Fuller
, count(case EmployeeID when 3 then 1 end) as Leverling
from Orders
