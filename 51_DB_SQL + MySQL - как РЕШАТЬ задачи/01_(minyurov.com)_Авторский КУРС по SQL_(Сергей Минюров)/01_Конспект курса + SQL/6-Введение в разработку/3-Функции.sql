create function SalesAmtByCust(@CustomerID nchar(5))
	returns money
begin
	return (select sum(od.Amount) as Amount
			from vOrderDetails as od
			join Orders as o on o.OrderID = od.OrderId
			where o.CustomerID = @CustomerId)
end
go
select [dbo].[SalesAmtByCust](CustomerID) as SalesAmount
, *
from Customers
where [dbo].[SalesAmtByCust](CustomerID) > 10000