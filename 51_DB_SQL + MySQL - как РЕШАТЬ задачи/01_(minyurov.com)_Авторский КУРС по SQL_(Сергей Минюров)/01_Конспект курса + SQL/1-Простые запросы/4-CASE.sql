use Northwind
-- Простой CASE
select ProductID, ProductName
, case Discontinued
	when 0 then 'В продаже'
	when 1 then 'Снят с производства'
  end [Статус товара]
from Products
-- Вариант
select ProductID, ProductName
, iif(Discontinued = 0, 'В продаже', 'Снят с производства') as [Статус товара]
from Products

select ProductName, UnitPrice
, case
	when UnitPrice < 10 then '< 10'
	when UnitPrice < 100 then '< 100'
	else '>= 100'
  end as [Уровень цены]
from Products

select ShipCountry
, case ShipCountry when 'France' then 1 end as France
, case ShipCountry when 'Germany' then 1 end as Germany
, case ShipCountry when 'Brazil' then 1 end as Brazil
from Orders
where ShipCountry in ('France', 'Germany', 'Brazil')

/*
1. Вывести справочник товаров и текстовое описание наличия товара (UnitInStocks)
2. Вывести заказы, которые были оформлены в города  Madrid, Bern, London и Paris и добавить колонки, которые выводят 1 для этих городов
*/

select ProductName, [UnitsInStock]
,iif(UnitsInStock > 0, 'В продаже', 'Кончилось') as [В наличие]
from Products

select ProductName, [UnitsInStock]
, case 
    when UnitsInStock > 0 
		then 'В продаже' 
	else 'Кончилось' 
  end as [В наличие]
from Products
--Заказы в городах
select ShipCity
, case ShipCity when 'Madrid' then 1 else 0 end as Madrid
, case ShipCity when 'Bern' then 1 end as Bern
, case ShipCity when 'London' then 1 end as London
, case ShipCity when 'Paris' then 1 end as Paris
from Orders
where ShipCity in ('Madrid','Bern','London','Paris')
