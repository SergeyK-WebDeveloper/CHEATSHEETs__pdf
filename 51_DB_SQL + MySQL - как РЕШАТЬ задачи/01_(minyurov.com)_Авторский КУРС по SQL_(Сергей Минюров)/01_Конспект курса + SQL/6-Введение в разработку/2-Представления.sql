CREATE view [dbo].[vOrderDetails] as 
select od.*, od.UnitPrice * od.Quantity * (1 - od.Discount) as Amount, p.ProductName
, c.CategoryID, c.CategoryName
from [Order Details] as od
join Products as p on od.ProductID = p.ProductID
join Categories as c on p.CategoryID = c.CategoryID
