/***********************
����� 2
***********************/

-- ��� 1. � ������� �������� �� ��������� ����� ������������ � ������ ��������� ������ ������ ��� �������������� ������
SELECT * FROM Territories
UPDATE Territories SET RegionID = RegionID

-- ��� 2.1. ���������� ������������ ����������� ������
UPDATE Territories SET RegionID = RegionID

-- ��� 2.2. ���������� ������ ������ � ��������� �� ��������� (READ COMMITED)
SELECT * FROM Territories

-- ��� 2.2. ������ "�������" ������ ��� ��������
SELECT * FROM Territories WITH (NOLOCK)

-- ��� 3. � ������� ������� �������� ����� ������������ � ������ ��������� ������ ������, �� ������ �������������� ������
SELECT * FROM Territories
UPDATE Territories SET RegionID = RegionID