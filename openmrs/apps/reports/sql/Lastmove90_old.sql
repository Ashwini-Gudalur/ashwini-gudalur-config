SELECT ROW_NUMBER() OVER (ORDER BY plmr.last_moved_date) as "Sl No",plmr.desc as Product,pc.name as Category,
sl.name as "Source Location",sll.name as "Dest location",cast(plmr.last_moved_date AS date) as date
  FROM prod_last_moved_report plmr
  INNER JOIN stock_location sl on sl.id = plmr.location_id
  INNER JOIN stock_location sll on sll.id = plmr.location_dest_id
  INNER JOIN Product_template pt on pt.id = plmr.product_id
  INNER JOIN product_category pc on pc.id = pt.categ_id
  WHERE plmr.last_moved_date < NOW() - INTERVAL '90 days'
  order by plmr.last_moved_date;

