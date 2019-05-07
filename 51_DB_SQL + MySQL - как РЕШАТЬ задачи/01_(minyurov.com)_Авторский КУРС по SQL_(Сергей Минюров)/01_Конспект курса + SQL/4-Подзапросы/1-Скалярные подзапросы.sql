use Northwind

select max(OrderId) from Orders
-- 11077
select *
from [Order Details]
where OrderId = 11077

select *
from [Order Details]
where OrderId = (
	-- ��������� ���������: ���� ������� � ���� ������
	select max(OrderId) from Orders
)

select *
from Orders
where CustomerID in (
	select CustomerID from Customers where Country = 'USA'
)

select *
from Orders
where CustomerID = ANY /* SOME */(
	select CustomerID from Customers where Country = 'USA'
)


select *
from Products 
where UnitPrice >= ANY (
	select max(UnitPrice)
	from Products
	group by CategoryID
)

select *
from [Order Details]
where Quantity > all (
	select avg(Quantity)
	from [Order Details]
	group by OrderId
)

select *
from [Order Details]
where Quantity > any (
	select sum(Quantity)
	from [Order Details]
	group by OrderId
)

-- ��������� ������ �� ������� ����������
select EmployeeID, max(OrderID) LastOrderId
from Orders
group by EmployeeID

select max(OrderID)
from Orders
where Orders.EmployeeID = 2

select LastName
, (select max(OrderID)
   from Orders
   -- ���������� �������� (����������)
   where Orders.EmployeeID = Employees.EmployeeID
) as LastOrderId
-- ��� ������ ������ ����������� ���������
from Employees

-- ������ ������
-- ����� ��������� ������ ��� ������� ����������
select o.EmployeeID, o.OrderID
from Orders as o
where OrderID = (
	select max(OrderID)
	from Orders as o2
   -- ���������� �������� (����������)
	where o.EmployeeID = o2.EmployeeID
)
-- ������� ��� �������
select c.*
from Customers as c
where 0 = (
	select count(*)
	from Orders as o
   -- ���������� �������� (����������)
	where c.CustomerID = o.CustomerID 
)
-- ����
select *
from Orders
where CustomerID in ('FISSA', 'PARIS')

select c.*
from Customers as c
-- ���������, ��� ��������� ������ ������
where not exists (
	select *
	from Orders as o
   -- ���������� �������� (����������)
	where c.CustomerID = o.CustomerID 
)

/*
1. � ����� ������� ���� ������������ ���������� ������� � ������ ����
2. ������� ������ �� ���������� � �����, � ������� ���� ������������ ���������� ������� � ���������� ������� �� ���� ���
3. ������� ������ �� ������� �������� c �����, � ������� ���� ������������ ���������� ������� � ���������� ������� �� ���� ���
4. ������ � ������������ ������ ������ �� ������� ������: �������� ������, ����� ������ � ������������ ������ ������ ����� ������
*/
select distinct year(OrderDate) as [Year]
, (
	select top 1 month(OrderDate) as MaxSalesMonth
	from Orders as o2
	where year(o2.OrderDate) = year(o.OrderDate)
	group by month(OrderDate)
	order by count(*) desc
) MaxSalesMonth
from Orders as o
-- ������� �������
select top 1 month(OrderDate) as MaxSalesMonth
from Orders as o2
where year(o2.OrderDate) = 1998
group by month(OrderDate)
order by count(*) desc

--2. ������� ������ �� ���������� � �����, � ������� ���� ������������ ���������� ������� � ���������� ������� �� ���� ���
select 
 CustomerID,
 Year(OrderDate) AS MaxYear,
 Count(*) AS OrderQty
from Orders AS OrdersOut
where Year(OrderDate) = (Select TOP (1) Year(OrderDate)
     from Orders AS OrdersIn
     where OrdersIn.CustomerID = OrdersOut.CustomerID
     group by Year(OrderDate) 
     order by count(*) desc)
group by CustomerID,Year(OrderDate)
