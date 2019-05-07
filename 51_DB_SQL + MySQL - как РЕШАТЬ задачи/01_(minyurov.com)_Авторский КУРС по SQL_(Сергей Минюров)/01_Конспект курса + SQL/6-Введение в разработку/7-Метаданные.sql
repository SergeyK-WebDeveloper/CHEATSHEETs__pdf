USE Northwind

-- Что такое метаданные?

-- Системные представления https://msdn.microsoft.com/ru-ru/library/ms177862.aspx
-- Функции метаданных https://msdn.microsoft.com/ru-ru/library/ms187812.aspx

-- Базы данных на сервере
SELECT * FROM sys.databases

-- Таблицы в текущей БД
SELECT * FROM sys.tables

-- Все объекты в текущей БД
SELECT * FROM sys.system_objects

-- ISO
SELECT * FROM INFORMATION_SCHEMA.TABLES