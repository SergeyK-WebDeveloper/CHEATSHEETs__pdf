-- —истемонезависимый формат: yyyymmdd, yyyy-mm-dd
declare @date as date = '2015-10-06'
select @date

declare @datetime as datetime = '2015-10-06 10:49:10.123'
select @datetime

select getdate(), getutcdate(), SYSDATETIMEOFFSET()

select year(getdate()), month(getdate()), day(getdate())

select datepart(q, getdate())

select datefromparts(2015,10,6)
, datetimefromparts(2015,10,6, 10,55,0,0)

select getdate() - 10

select dateadd(yy, -1, getdate()), dateadd(q, 1, getdate())

select datediff(s, getdate(), getdate()+1)

select EOMONTH(getdate())

/*
1. ¬ывести возраст сотрудников в годах и мес€цах
2. ¬ывести плановый и фактический срок поставки в дн€х
*/
 -- “очность до мес€ца
 select BirthDate, datediff(mm,BirthDate,getdate())/12
, datediff(mm,BirthDate,getdate())%12
from Employees

--2. ¬ывести плановый и фактический срок поставки в дн€х
select OrderID,
  OrderDate,
  RequiredDate,
  ShippedDate,
  DATEDIFF(day,OrderDate,RequiredDate) AS PlanDays,
  DATEDIFF(day,OrderDate,ShippedDate) AS FactDays
from Orders