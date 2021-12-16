
--1. Report the distribution of the turnover of the Buffalo bikes store by months of the year.

    select   A.store_name , month ( order_date) month_of_year  ,sum((C.quantity*C.list_price)*(1-C.discount)) as distribution_of_turnover
	from sale.store A, sale.orders B, sale.order_item C
	where A.store_id =B.store_id and B.order_id=C.order_id  and A.store_name ='Buffalo Bikes'
    group by  A.store_name, month ( order_date)
	order by month_of_year

--2.Report the distribution of the turnover of the Buffalo bikes store by days of the week.

    select   A.store_name , datepart(WEEKDAY, order_date) day_of_week  ,sum((C.quantity*C.list_price)*(1-C.discount)) as distribution_of_turnover
	from sale.store A, sale.orders B, sale.order_item C
	where A.store_id =B.store_id and B.order_id=C.order_id  and A.store_name ='Buffalo Bikes'
    group by  A.store_name, datepart(WEEKDAY, order_date)
	order by distribution_of_turnover DESC
	