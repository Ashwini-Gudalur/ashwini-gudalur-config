SELECT ROW_NUMBER() OVER (ORDER BY sm.create_date) as "Sl No",sm.name as Product,pc.name as "Product category",spl.name as Batch,sm.product_qty as Quantity,
spl.mrp as MRP,cast((spl.mrp*sm.product_qty)as DECIMAL (10,2)) as "MRP Value",
spl.cost_price as CP,cast((spl.cost_price*sm.product_qty)as DECIMAL (10,2)) as "CP Value",spl.sale_price as SP,
cast((spl.sale_price*sm.product_qty)as DECIMAL(10,2)) as "SP Value",
cast(sm.create_date as date),sl.name as Location,sll.name as "Source Location"
  FROM stock_move sm
   INNER JOIN stock_location sl on sl.id = sm.location_dest_id
   INNER JOIN stock_location sll on sll.id = sm.location_id
   INNER JOIN stock_production_lot spl on spl.id = sm.prodlot_id
   INNER JOIN product_template pt ON pt.id = sm.product_id
   INNER JOIN product_category pc on pc.id = pt.categ_id
      WHERE sl.name Not like 'Customers'
         AND sm.state = 'done'
           AND cast(sm.create_date as date) between '#startDate#' and '#endDate#'
           ORDER BY sm.create_date Asc;
