-- ANSI/ISO
select cast(1000 as varchar) + ' רע.'
-- T-SQL
select convert(varchar, 1000) + ' רע.'

set dateformat dmy
select cast('12.23.2015' as date)
select cast('23.12.2015' as date)

select convert(date, '12.23.2015', 101)
select convert(date, '23.12.2015', 104)

select cast('123.456' as numeric(10,3))
, try_cast('123,456' as numeric(10,3))
, parse('123,456' as numeric(10,3) using 'ru-RU')