use Northwind
-- ������� CASE
select ProductID, ProductName
, case Discontinued
	when 0 then '� �������'
	when 1 then '���� � ������������'
  end [������ ������]
from Products
-- �������
select ProductID, ProductName
, iif(Discontinued = 0, '� �������', '���� � ������������') as [������ ������]
from Products

select ProductName, UnitPrice
, case
	when UnitPrice < 10 then '< 10'
	when UnitPrice < 100 then '< 100'
	else '>= 100'
  end as [������� ����]
from Products

select ShipCountry
, case ShipCountry when 'France' then 1 end as France
, case ShipCountry when 'Germany' then 1 end as Germany
, case ShipCountry when 'Brazil' then 1 end as Brazil
from Orders
where ShipCountry in ('France', 'Germany', 'Brazil')

/*
1. ������� ���������� ������� � ��������� �������� ������� ������ (UnitInStocks)
2. ������� ������, ������� ���� ��������� � ������  Madrid, Bern, London � Paris � �������� �������, ������� ������� 1 ��� ���� �������
*/

select ProductName, [UnitsInStock]
,iif(UnitsInStock > 0, '� �������', '���������') as [� �������]
from Products

select ProductName, [UnitsInStock]
, case 
    when UnitsInStock > 0 
		then '� �������' 
	else '���������' 
  end as [� �������]
from Products
--������ � �������
select ShipCity
, case ShipCity when 'Madrid' then 1 else 0 end as Madrid
, case ShipCity when 'Bern' then 1 end as Bern
, case ShipCity when 'London' then 1 end as London
, case ShipCity when 'Paris' then 1 end as Paris
from Orders
where ShipCity in ('Madrid','Bern','London','Paris')
