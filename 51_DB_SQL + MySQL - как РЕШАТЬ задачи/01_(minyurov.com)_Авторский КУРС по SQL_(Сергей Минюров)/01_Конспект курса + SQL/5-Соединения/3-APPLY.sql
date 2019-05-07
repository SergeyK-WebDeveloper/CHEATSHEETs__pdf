use Northwind

select c.CompanyName, o.OrderID, o.OrderDate
from Customers as c
join Orders as o on c.CustomerID = o.CustomerID
order by 1
/* JOIN:
1. ������ ������ �� 1-� �������
2. ������ ������ �� 2-� �������
3. ��������� ������ �� 1-� � 2-� ������� */
-- ��������� ����� ��� ������� ���������
select c.CompanyName, o.OrderID, o.OrderDate
from Customers as c
cross apply (select top 1 * 
             from Orders as o
			 where o.CustomerID = c.CustomerID
			 order by o.OrderDate desc) as o
order by 1
/* APPLY:
1. ������ ������ �� 1-� �������
1.1. ��� ������ ������ �� 1-� ������� ��������� ��������� */

select c.CompanyName, o.OrderID, o.OrderDate
from Customers as c
join (select top 1 * from Orders) as o
			 on o.CustomerID = c.CustomerID
order by 1

/*
1. ��� ������� ������ ������� ����� ������� ����� � ��� ���������
*/
select t.ProductName, o.OrderID, t.CategoryName
from Orders as o
cross apply (
	select top 1 p.ProductName, c.CategoryName 
	from [Order Details] as od			
		join Products as p 
			on od.ProductID =	p.ProductID
		join Categories as c on								p.CategoryID = c.CategoryID
	where o.OrderID = od.OrderID
	order by od.UnitPrice desc)
 as t



select OrderId, max(UnitPrice) as MaxPrice
from [Order Details]
group by OrderID


select count(*)
from Orders