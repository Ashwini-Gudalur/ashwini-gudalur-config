SELECT
rp.name as "Patient Name",
case when rpa."x_Is_Tribal"='True' then 'Tribal' 
else 'Non-Tribe' end as IsTribe,
so.care_setting,
rp.ref as Patient_id,
so.name as "Sale order",
so.amount_untaxed as "Total Billed",
so.discount_amount as "Discount Amount",
so.amount_total as "To Pay",
cast(sol.create_date as date)
FROM sale_order so
INNER join sale_order_line sol on sol.order_id=so.id
INNER JOIN res_partner_attributes rpa on rpa.partner_id=so.partner_id
LEFT JOIN res_partner rp on rp.id=sol.order_partner_id
WHERE product_id IN(
  SELECT pp.id
  FROM product_product pp
    INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
  WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping
                          WHERE chargetype_name = 'Investigations'))
      AND cast(sol.create_date as date) BETWEEN '#startDate#' and '#endDate#'
      AND (sol.state = 'confirmed')
     GROUP BY order_id,so.care_setting,
              rp.ref ,
              rp.name ,
              so.name ,
              so.amount_untaxed ,
              so.discount_amount ,
              so.amount_total ,
              sol.create_date,
              rpa."x_Is_Tribal"
     order by rp.name asc;
