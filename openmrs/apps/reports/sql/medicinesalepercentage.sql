SELECT pt.name as "Product name",
	ROUND(SUM(sm.product_qty),2) as "Total sale by product",
	to_char(round(100.0*(sum(sm.product_qty))/(SUM(SUM(sm.product_qty))
								OVER()),2), 'FM990.00" %"')as Percentage 
from stock_move sm
inner JOIN product_template pt on pt.id=product_id 
WHERE sm.location_id = 15 and sm.location_dest_id = 9 
and  cast(sm.write_Date as DATE) BETWEEN '#startDate#' and '#endDate#'
GROUP by sm.product_id,pt.name
ORDER BY Percentage desc;
