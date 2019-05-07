use Northwind

select EmployeeID, LastName + ' ' + FirstName as FullName -- ����� ������� (���������)
--select EmployeeID, LastName + ' ' + FirstName FullName
--select EmployeeID
--     , FullName = LastName + ' ' + FirstName
--select EmployeeID, LastName + ' ' + FirstName as [Full Name]
--select EmployeeID, LastName + ' ' + FirstName as "Full Name"
--select EmployeeID, LastName + ' ' + FirstName as 'Full Name'
from Employees

select *--, UnitPrice * Quantity * (1 - Discount) as Amount
from [Order Details]
where UnitPrice * Quantity * (1 - Discount) > 1000

-- ������� - ����� �������������� �����������
select t.* from (
	select *, UnitPrice * Quantity * (1 - Discount) as Amount
	from [Order Details]
) as t
where Amount > 1000

-- ���������� �������, � ������� ���� �������
select distinct ShipCountry, ShipCity -- ������ ��������� ������!!!
from Orders


