/***********************
����� 1
***********************/

-- ����������� �� ���������� � ���������� �������� ����� ���������� SQL Server
-- https://technet.microsoft.com/ru-ru/library/jj856598(v=sql.110).aspx
-- �������� ���������� ������
-- http://minyurov.com/2014/01/02/sql-data-share/
-- ������ ��������
-- https://msdn.microsoft.com/ru-ru/library/ms173763.aspx
-- ��������� �������� 
-- https://msdn.microsoft.com/ru-ru/library/ms187373.aspx

-- ��� 1. �������� ������ � ������ ��������� �� ��������� ������ �������� (���������� ����������).

BEGIN TRAN -- "�������" ����������
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/

-- ��� 2. �������� ����������� ��������� ������ �������� ����������� (����������� ����������) � �������� ������ � ���������

BEGIN TRAN -- "�������" ����������
UPDATE Territories SET TerritoryDescription = '!'
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/

-- ��� 3. �������� ������ � ������� ��������� ��������� ������ �������� ����������� ������
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN -- "�������" ����������
SELECT * FROM Territories
SELECT @@TRANCOUNT
/*
ROLLBACK
SELECT @@TRANCOUNT
*/