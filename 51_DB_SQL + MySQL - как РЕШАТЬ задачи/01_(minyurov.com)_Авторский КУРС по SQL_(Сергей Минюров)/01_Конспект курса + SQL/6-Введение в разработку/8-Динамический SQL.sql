USE Northwind

-- Что такое метаалгоритмы?

DECLARE @Command AS nvarchar(1000) = 'SELECT * FROM Orders'

SELECT @Command

EXEC (@Command)

DECLARE @SQL AS NVARCHAR(MAX), @Column AS NVARCHAR(MAX)
 
--Get distinct values of the PIVOT Column 
SELECT @Column= ISNULL(@Column + ',','') 
       + QUOTENAME(EmployeeID)
FROM (SELECT DISTINCT EmployeeID FROM Orders) AS t

PRINT @Column
 
--Prepare the PIVOT query using the dynamic 
SET @SQL = 
  N'SELECT ShipCountry, ' + @Column + '
    FROM (SELECT ShipCountry, EmployeeID, COUNT(*) Qty FROM Orders GROUP BY ShipCountry, EmployeeID) t
    PIVOT(SUM(Qty) FOR EmployeeID IN (' + @Column + ')) AS t'

PRINT @SQL

EXEC (@SQL)