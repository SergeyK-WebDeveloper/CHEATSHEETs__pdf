use Northwind

-- Одинаковое количество колонок и совместимость типов
-- Название колонок определяется в первом запросе

-- UNION - Объединение 
select CompanyName 
from Customers
union -- как DISTINCT
select CompanyName
from Suppliers
union
select CompanyName
from Shippers
order by CompanyName -- Общая сортировка

select CustomerID as ID, CompanyName, 'Customer' as [Role]
from Customers
union all -- Не проверяет дубли и работает быстрее
select cast(SupplierID as varchar), CompanyName, 'Supplier'
from Suppliers
union all
select cast(ShipperID as varchar), CompanyName, 'Shipper'
from Shippers
order by CompanyName

-- INTERSECT - Пересечение - общие данные
select TerritoryDescription
from Territories
intersect
select ShipCity
from Orders

-- EXCEPT - Вычитание - разница
select TerritoryDescription
from Territories
except
select ShipCity
from Orders

select ShipCity
from Orders
except
select TerritoryDescription
from Territories
union all 
select RegionDescription
from Region
order by 1

/*
1. Заказчики без заказов в 1998 году
2. Товары, которые не продавались в 1996 году
*/

--1. Заказчики без заказов в 1998 году
select distinct CustomerID
from Orders
except
select CustomerID
from Orders
where year(OrderDate) = 1998

select ProductId
from Products
except
select distinct ProductID
from [Order Details] as od join Orders as o 
 on o.OrderID = od.OrderID
where year(o.OrderDate)=1996
