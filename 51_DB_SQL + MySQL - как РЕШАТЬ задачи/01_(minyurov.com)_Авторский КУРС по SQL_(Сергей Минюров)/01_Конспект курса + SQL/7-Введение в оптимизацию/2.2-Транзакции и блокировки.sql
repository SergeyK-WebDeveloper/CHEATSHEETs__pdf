/***********************
СЕАНС 2
***********************/

-- Шаг 1. С уровнем изоляции по умолчанию можно одновременно с другой операцией чтения читать или модифицировать данные
SELECT * FROM Territories
UPDATE Territories SET RegionID = RegionID

-- Шаг 2.1. Блокировка параллельной модификации данных
UPDATE Territories SET RegionID = RegionID

-- Шаг 2.2. Блокировка чтения данных с изоляцией по умолчанию (READ COMMITED)
SELECT * FROM Territories

-- Шаг 2.2. Чтение "грязных" данных без изоляции
SELECT * FROM Territories WITH (NOLOCK)

-- Шаг 3. С высоким уровнем изоляции можно одновременно с другой операцией чтения читать, но нельзя модифицировать данные
SELECT * FROM Territories
UPDATE Territories SET RegionID = RegionID