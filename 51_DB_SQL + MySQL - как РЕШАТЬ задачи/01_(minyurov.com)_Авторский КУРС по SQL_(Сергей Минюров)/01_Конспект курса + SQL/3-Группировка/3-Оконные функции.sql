select count(*) as Lines
, count(distinct ProductId) as Products
, count(distinct OrderId) as Orders
from [Order Details]
-- ���������� ��������� � ���������� ������
-- ������ SELECT ��� ��������
select *
, (select count(*) from [Order Details]) as Lines
, (select count(distinct ProductId) from [Order Details]) as Products
, (select count(distinct OrderId) from [Order Details]) as Orders
from [Order Details]
-- OVER - ����������� ������ � �������� ���������
-- ��������� ������ � ��������� � ����� ���������
select *
, count(*) over() as Orders
, count(*) over(PARTITION BY ProductId) as OrdersByProduct
, sum(Quantity) over() as TotalQty
, sum(Quantity) over(PARTITION BY ProductId) as QtyByProduct
, sum(Quantity) over(PARTITION BY OrderId) as QtyByOrder
from [Order Details]
-- ������� �����
select OrderId, ProductID, Quantity
, sum(Quantity) over(PARTITION BY OrderId) as QtyByOrder
, sum(Quantity) over(
	PARTITION BY OrderId	-- ���� ������
	ORDER BY ProductId		-- �������
	ROWS BETWEEN			-- �������� �� ���� ������
	UNBOUNDED PRECEDING		-- ������ ��������� � ���� ������
		AND CURRENT ROW		-- ����� ��������� � ���� ������
) as RunningQtyByOrder
, sum(Quantity) over() as TotalQty
, sum(Quantity) over(
    ORDER BY OrderId, ProductId
	ROWS BETWEEN
	UNBOUNDED PRECEDING
		AND CURRENT ROW) as RunningQty
from [Order Details]

-- ������������ ������ - ������ ���������
select OrderId, ProductID, Quantity
, ROW_NUMBER() over (ORDER BY OrderId, ProductID) as [LineNo]
, ROW_NUMBER() over (PARTITION BY OrderId ORDER BY ProductID) as [LineNoByOrder]
, ROW_NUMBER() over (PARTITION BY ProductID ORDER BY OrderId) as [LineNoByProduct]
from [Order Details]

-- �������� ������������
select ProductID, UnitPrice
, ROW_NUMBER() over(ORDER BY UnitPrice desc) AS NumByUnitPricer
, RANK() over(ORDER BY UnitPrice desc) as RankByUnitPrice
, DENSE_RANK() over(ORDER BY UnitPrice desc) as DenseRankByUnitPrice
, NTILE(3) over(ORDER BY UnitPrice desc) as GroupByPrice
from Products
-- ������������ � ������������
select ProductID, CategoryID, UnitPrice
, ROW_NUMBER() over(PARTITION BY CategoryID ORDER BY UnitPrice desc) AS NumByUnitPricer
, RANK() over(PARTITION BY CategoryID ORDER BY UnitPrice desc) as RankByUnitPrice
, DENSE_RANK() over(PARTITION BY CategoryID ORDER BY UnitPrice desc) as DenseRankByUnitPrice
, NTILE(3) over(PARTITION BY CategoryID ORDER BY UnitPrice desc) as GroupByPrice
from Products
-- ������� ��������
select OrderId, CustomerId
, lag(OrderId,1) over (partition by CustomerId order by OrderId) as PrevIdByCustomer
, lag(OrderId,2,0) over (order by OrderId) as Prev2Id
, lead(OrderId,1) over (order by OrderId) as NextId
, lead(OrderId,2) over (order by OrderId) as Next2Id
from Orders
order by CustomerID, OrderId
-- ������� ���� ����� �������� ������ ���������
select CustomerID, OrderID
, lag(OrderDate,1) over (PARTITION BY CustomerID order by OrderID) as PrevDate
, OrderDate
, DATEDIFF(d, lag(OrderDate,1) over (PARTITION BY CustomerID order by OrderID), OrderDate) as 'DateDiff'
from Orders
Order by CustomerID

-- ����������� �������
select CategoryID, ProductID, UnitPrice
, FIRST_VALUE(UnitPrice) over (order by CategoryId) as FirstPriceByCategory
, LAST_VALUE(UnitPrice) over (order by CategoryId) as LastPriceByCategory
, min(UnitPrice) over (partition by CategoryId) as MinPrice
, max(UnitPrice) over (partition by CategoryId) as maxPrice
from Products
/*
1. ��������� �� ����������� ����� ������� � ���� �� ����� ������
2. ������� ��� �������, ������������ � ������� ����� ������, ������� ����������, ����� �� ������, ����� �� ����������, ������� �� ����������
3. ����� ����������� (���, �������), � ������� �� ���� ����������� ����� ��������, ����������� �������
*/

--1. ��������� �� ����������� ����� ������� � ���� �� ����� ������
select distinct EmployeeId
, sum(od.UnitPrice * od.Quantity) over(partition by EmployeeID) as AmountByEmployee
, sum(od.UnitPrice * od.Quantity) over() as TotalAmount
, sum(od.UnitPrice * od.Quantity) over(partition by EmployeeID) 
/ sum(od.UnitPrice * od.Quantity) over() as Rate
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
--2. ������� ��� �������, ������������ � ������� ����� ������, ������� ����������, ����� �� ������, ����� �� ����������, ������� �� ����������
--, sum(Quantity) over() as TotalQty

select o.OrderID, e.LastName
, sum(od.UnitPrice*od.Quantity) AmountOfOrders
--, 
from Orders as o
join Employees as e on o.EmployeeID = e.EmployeeID
join [Order Details] as od on o.OrderID = od.OrderID
where o.ShipCountry = 'Mexico'
group by o.OrderID, e.LastName

select o.OrderID
, sum(od.UnitPrice*od.Quantity) AmountOfOrders
from Orders as o
--join Employees as e on o.EmployeeID = e.EmployeeID
join [Order Details] as od on o.OrderID = od.OrderID
where o.ShipCountry = 'Mexico'
group by o.OrderID--, e.LastName

select o.EmployeeID
, sum(od.UnitPrice*od.Quantity) AmountOfEmpl
from Orders as o
--join Employees as e on o.EmployeeID = e.EmployeeID
join [Order Details] as od on o.OrderID = od.OrderID
where o.ShipCountry = 'Mexico'
group by o.EmployeeID

;with ttt as(
select distinct o.OrderID, o.EmployeeID
, sum(od.UnitPrice*od.Quantity)  over(partition by o.EmployeeID) as AmountOfEmpl
, sum(od.UnitPrice*od.Quantity)  over(partition by o.OrderID) as AmountOfOrders
from Orders as o
join [Order Details] as od on o.OrderID = od.OrderID
where o.ShipCountry = 'Mexico'
)
select *, rank() over(order by ttt.AmountOfEmpl) as RateOFEmp 
from ttt

--3. ����� ����������� (���, �������), � ������� �� ���� ����������� ����� ��������, ����������� �������
select distinct t.ContactName
from ( 
	select c.ContactName
	, lag(o.OrderDate,1) over (partition by c.ContactName order by o.OrderId) as PrevDate
	, o.OrderDate
	, DATEDIFF(d, (lag(o.OrderDate,1) over (partition by c.ContactName order by o.OrderDate)), OrderDate) as Differen
	from Customers as c
	join Orders as o on c.CustomerID = o.CustomerID
) as t
where t.Differen < 180

-- ��������
Select DaysOrd.CustID,
  Cust.ContactName,
  max(DaysOrd.Months) AS MaxDiff
From 
(
  select  CustomerID As CustID,
  OrderID As OrdID, 
  OrderDate As OrdDate,
  LAG(OrderDate,1) over (Partition by CustomerID order by OrderDate,OrderID) as PrevDate,
  DATEDIFF(m,LAG(OrderDate,1) over (Partition by CustomerID order by OrderDate,OrderID),OrderDate) AS Months
from Orders) AS DaysOrd
Join Customers As Cust ON DaysOrd.CustID = Cust.CustomerID
group by DaysOrd.CustID,Cust.ContactName
having max(DaysOrd.Months)<6
