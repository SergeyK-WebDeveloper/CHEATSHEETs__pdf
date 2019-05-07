/***********************
СЕАНС 1
***********************/

-- Руководство по блокировке и управлению версиями строк транзакций SQL Server
-- https://technet.microsoft.com/ru-ru/library/jj856598(v=sql.110).aspx
-- Алгоритм блокировки данных
-- http://minyurov.com/2014/01/02/sql-data-share/
-- Уровни изоляции
-- https://msdn.microsoft.com/ru-ru/library/ms173763.aspx
-- Табличные указания 
-- https://msdn.microsoft.com/ru-ru/library/ms187373.aspx

-- Шаг 1. Операция чтения с низкой изоляцией не блокирует другие операции (совместные блокировки).

BEGIN TRAN -- "Висящая" транзакция
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/

-- Шаг 2. Операция модификации блокирует другие операции модификации (монопольные блокировки) и операции чтения с изоляцией

BEGIN TRAN -- "Висящая" транзакция
UPDATE Territories SET TerritoryDescription = '!'
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/

-- Шаг 3. Операция чтения с высокой изоляцией блокирует другие операции модификации данных
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN -- "Висящая" транзакция
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/