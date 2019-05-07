select 1 + 1, '1' + '1', 1 + '1', '1' + 1

select 1 + cast('1' as int)

select cast(1 as char(1)) + 'шт.'

select 5 / 2., 5 % 2, $5 / 2

select isnumeric('123'), isnumeric('123b')

declare @num as numeric(10, 6) = 1234.5678
select @num
--, floor(@num), ceiling(@num)
--, round(@num, 2), round(@num, -2)
, round(@num, 2, 0) -- мат. округление (по умолчанию)
, round(@num, 2, 1) -- усечение