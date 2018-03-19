SELECT ROW_NUMBER() OVER (ORDER BY asp.product_name) as "Sl No",asp.product_name,asp.Category,
trim(to_char(asp.avg_sale_price,'9999990.99'))  as "Sale Price"
FROM (select pol.name as product_name,pc.name as Category,CAST(avg(spl.sale_price) AS DECIMAL(10,2)) AS avg_sale_price 
FROM  purchase_order_line pol
INNER JOIN purchase_order po on po.id = pol.order_id
INNER JOIN res_partner rs on rs.id = pol.partner_id
INNER JOIN stock_move sm on sm.purchase_line_id = pol.id
INNER JOIN stock_production_lot spl on spl.id = sm.prodlot_id
INNER JOIN product_template pt on pt.id = pol.product_id
LEFT JOIN product_category pc on pc.id = pt.categ_id
Where pol.state = 'confirmed'
group by pol.name,pc.name) as asp 
GROUP by asp.product_name,asp.Category,asp.avg_sale_price
ORDER by asp.product_name;
