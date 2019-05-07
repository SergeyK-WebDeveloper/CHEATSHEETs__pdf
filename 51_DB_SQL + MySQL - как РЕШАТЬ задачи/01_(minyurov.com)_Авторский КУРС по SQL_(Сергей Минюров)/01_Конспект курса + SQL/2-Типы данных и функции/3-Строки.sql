select LastName, FirstName
--, upper(LastName), lower(LastName)
--, reverse(LastName)
--, len(LastName), DATALENGTH(LastName)
--, left(FirstName, 1), right(FirstName,3)
--, substring(FirstName, 3, 2)
--, charindex('a', FirstName) -- первая а
--, charindex('a', FirstName, charindex('a', FirstName)+1) -- вторая а
--, space(10) + FirstName
--, replicate('-|', 10) + FirstName
--, rtrim(ltrim(space(10) + FirstName + space(10)))
, replace(LastName, 'a', 'A')
, stuff(LastName, 3, 0, '---')
, stuff(LastName, 3, 3, '---')
from Employees

select Country, Region, Country + ' ' + isnull(Region,'')
, concat(Country, ' ', Region)
from Employees