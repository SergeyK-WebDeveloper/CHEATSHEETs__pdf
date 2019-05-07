use Northwind

-- ���������� ���������� ������� � ������������� �����
-- �������� ������� ������������ � ������ �������

-- UNION - ����������� 
select CompanyName 
from Customers
union -- ��� DISTINCT
select CompanyName
from Suppliers
union
select CompanyName
from Shippers
order by CompanyName -- ����� ����������

select CustomerID as ID, CompanyName, 'Customer' as [Role]
from Customers
union all -- �� ��������� ����� � �������� �������
select cast(SupplierID as varchar), CompanyName, 'Supplier'
from Suppliers
union all
select cast(ShipperID as varchar), CompanyName, 'Shipper'
from Shippers
order by CompanyName

-- INTERSECT - ����������� - ����� ������
select TerritoryDescription
from Territories
intersect
select ShipCity
from Orders

-- EXCEPT - ��������� - �������
select TerritoryDescription
from Territories
except
select ShipCity
from Orders

select ShipCity
from Orders
except
select TerritoryDescription
from Territories
union all 
select RegionDescription
from Region
order by 1

/*
1. ��������� ��� ������� � 1998 ����
2. ������, ������� �� ����������� � 1996 ����
*/

--1. ��������� ��� ������� � 1998 ����
select distinct CustomerID
from Orders
except
select CustomerID
from Orders
where year(OrderDate) = 1998

select ProductId
from Products
except
select distinct ProductID
from [Order Details] as od join Orders as o 
 on o.OrderID = od.OrderID
where year(o.OrderDate)=1996
