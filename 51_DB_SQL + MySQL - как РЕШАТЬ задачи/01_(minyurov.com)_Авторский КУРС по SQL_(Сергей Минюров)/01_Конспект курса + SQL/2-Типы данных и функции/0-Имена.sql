use Northwind

-- Краткое имя: Объект
select * from Customers
-- Стандартное имя: Схема.Объект
-- Схема - классификатор данных, контейнер безопасности
select * from dbo.Customers
-- Расширенное имя: БД.Схема.Объект
select * from AdventureWorks2014.HumanResources.Department
-- Полное имя: Сервер(IP).БД.Схема.Объект
select * from [CKO-ALM4NO8U7O1].AdventureWorks2014.HumanResources.Department