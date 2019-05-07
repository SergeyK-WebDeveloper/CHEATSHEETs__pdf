use Northwind

select *
from Products
order by ProductName desc

select *
from Products
order by CategoryID asc, UnitPrice desc

-- ����������� ����� ��� DISTINCT
select distinct ProductName
from Products
order by ProductName desc


select ProductID, ProductName, UnitPrice
from Products
order by 3 desc, 2


select *, UnitPrice * Quantity as Amount
from [Order Details]
order by Amount

select *
from [Order Details]
order by UnitPrice * Quantity

-- ��������
select top (10) *
from Products
order by UnitPrice desc

select top (10) percent *
from Products
order by UnitPrice desc

select top (11) with ties * -- "�������" - ������������ ��������� ������
from Products
order by UnitPrice desc

select *
from Products
order by UnitPrice desc
	offset 10 rows -- ���������� ������ 10 �������
	fetch next 10 rows only -- ����� ��������� 10 �������
