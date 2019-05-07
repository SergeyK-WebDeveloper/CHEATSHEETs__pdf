use Northwind
-- C(reate)R(read)U(pdate)D(elete)
-- INSERT - ������� ����� ������

insert into Demo (Name) values ('Text1')
insert into Demo (Name, CreatedDate) values ('Text1', getdate()-1)
insert into Demo (Name, CreatedDate) values 
('Text3', getdate()+1), 
('Text4', getdate()+2)

insert into Demo (Name) 
output inserted.*
values ('Text5'), ('Text6')

-- ������� �� ������ �������
insert into Demo (Name) 
select LastName
from Employees

-- UPDATE - ���������� ������
update Demo
set Name = Name + ' ' + e.FirstName
output deleted.Name, inserted.Name
from Demo as d
join Employees as e on d.Name = e.LastName

-- DELETE - �������� ������
delete from Demo
where Id = 1

select * from Demo

delete from Demo
output deleted.*
where Id = 2

begin tran -- ������ ����������
	delete from Demo

	select * from Demo
	-- ����������� ��������
rollback -- �������� ����������
-- commit -- �������� ����������
select * from Demo

