SELECT 
cast(sm.create_date as date) as Last_move_date,
sm.name,
pc.name as Category,
spl.cost_price as CP,
spl.sale_price as SP,
cast((spl.cost_price*sm.product_qty)as DECIMAL (10,2)) as "CP Value",
cast((spl.sale_price*sm.product_qty)as DECIMAL(10,2)) as "SP Value"
 FROM stock_move sm
 INNER JOIN (select product_id,max(create_date) as MaxDate
 	        from stock_move
 	        group by product_id) smm on sm.product_id = smm.product_id and sm.create_date = smm.MaxDate
 INNER JOIN stock_production_lot spl on spl.id = sm.prodlot_id
 INNER JOIN Product_template pt on pt.id = sm.product_id
 INNER JOIN product_category pc on pc.id = pt.categ_id
 WHERE spl.sale_price is not null
 AND
  sm.create_date < NOW() - INTERVAL '90 days'
 ORDER BY spl.sale_price desc;
