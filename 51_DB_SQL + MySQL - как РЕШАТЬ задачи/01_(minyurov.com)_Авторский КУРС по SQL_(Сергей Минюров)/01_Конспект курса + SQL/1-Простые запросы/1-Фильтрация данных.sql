use Northwind
-- Без фильтрации по колонкам и строкам
select * from Employees
-- Фильтрация по колонкам
select EmployeeID, LastName, FirstName, Title
from Employees

-- Фильтрация по строкам
select EmployeeID, LastName, FirstName, Title
from Employees
--where EmployeeID = 1
--where EmployeeID <> 1 -- ANSI/ISO
--where EmployeeID != 1	-- T-SQL диалект (расширения)
--where NOT (EmployeeID = 1)
--where EmployeeID > 1 AND EmployeeID < 5
--where EmployeeID between 1 AND 5
where EmployeeID >= 1 AND EmployeeID <= 5 -- as BETWEEN


select EmployeeID, LastName, FirstName, Title
from Employees
--where Title = 'Sales Representative'
--where Title <> 'Sales Representative'
--where Title = 'Sales Representative' 
--   OR Title = 'Sales Manager'
where Title IN ('Sales Representative','Sales Manager')

select EmployeeID, LastName, FirstName, Title
from Employees
where Title like '%Sales%'

select EmployeeID, LastName, FirstName, TitleOfCourtesy
from Employees
--where TitleOfCourtesy like 'M%.'
--where TitleOfCourtesy like 'M_.'
--where TitleOfCourtesy like 'M[rsz].'
--where TitleOfCourtesy like 'M[r-s].'
--where TitleOfCourtesy like 'M[^abcdef].'
where TitleOfCourtesy like 'M%.!%' escape '!'

select EmployeeID, LastName, FirstName, TitleOfCourtesy
from Employees
where FirstName = 'An''ne'

select EmployeeID, LastName, Region, Country
from Employees
--where Region IS NULL
--where NOT Region IS NULL
where Region IS NOT NULL

select EmployeeID, LastName
, ISNULL(Region,'-') -- T-SQL
, COALESCE(Region, Country, '-') -- ANSI/ISO
from Employees

/*
1. Прочитать справочник товаров
- только актуальные товары
- только идентификатор товара, название и стандартную цену
2. Прочитать товары по заказам
- только товары без скидки
- только идентификатор товара и количество
3. Прочитать заказчиков, у которых факс не определен
4. Прочитать заказчиков, у которых одинаковый телефон и факс
*/
select ProductId, ProductName, UnitPrice
from Products
where Discontinued = 0

select ProductId, Quantity
from [Order Details]
where Discount = 0

select *
from Customers
where Fax IS NULL

select *
from Customers
where Fax = Phone