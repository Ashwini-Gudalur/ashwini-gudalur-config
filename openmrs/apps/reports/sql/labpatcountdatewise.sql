SELECT ROW_NUMBER() OVER (ORDER BY rp.ref) as "Sl No",rp.ref,count(rp.ref) as visit_count,date(so.create_date),rp.name,
(case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
else 'Tribe' END) as Caste from account_voucher av
LEFT JOIN account_voucher_line avl on avl.voucher_id=av.id
LEFT JOIN account_move_line aml on avl.move_line_id = aml.id
LEFT JOIN res_partner_attributes rpa on rpa.partner_id=av.partner_id
LEFT JOIN sale_order so on so.name = aml.ref
LEFT JOIN res_partner rp on rp.id = so.partner_id
WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
  WHERE product_id IN(SELECT pp.id FROM product_product pp INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
  WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping WHERE chargetype_name = 'Investigations')))
and av.amount>0 and avl.amount >0 and av.state='posted' AND so.care_setting = 'opd'
and date(av.date_string) BETWEEN '#startDate#' and '#endDate#'
Group by rp.ref,date(so.create_date),rp.name,rpa."x_Is_Tribal"
Order by rpa."x_Is_Tribal";
