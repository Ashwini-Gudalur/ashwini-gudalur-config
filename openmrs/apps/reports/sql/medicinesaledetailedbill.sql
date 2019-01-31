SELECT ROW_NUMBER() OVER (ORDER BY rp.ref) as "Sl No",rp.ref,rp.name,so.name as "SO",date(so.create_date),
trim(to_char(avl.amount, '9999990.99')) as "Collected",rpa."x_Tribe" as tribe,(case when rpa."x_Is_Premium_Paid" = 'False' then 'PP' else 'not pp' end) as pp,rpaa.address2,rpaa.city_village,(case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
else 'Tribe' END) as Caste,(case when rpa."x_Is_Sangam" = 'False' then 'Non sangam'
else 'Sangam' END) as Sangam  from account_voucher av
LEFT JOIN account_voucher_line avl on avl.voucher_id=av.id
LEFT JOIN account_move_line aml on avl.move_line_id = aml.id
LEFT JOIN res_partner_attributes rpa on rpa.partner_id=av.partner_id
INNER JOIN res_partner_address rpaa on rpaa.partner_id=av.partner_id
LEFT JOIN sale_order so on so.name = aml.ref
LEFT JOIN res_partner rp on rp.id = so.partner_id
WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
  WHERE product_id IN(SELECT pp.id FROM product_product pp INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
  WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping WHERE chargetype_name = 'Medicines')))
and av.amount>0 and avl.amount >0 and av.state='posted' AND so.care_setting = 'opd'
and cast(av.date_string as DATE) BETWEEN '#startDate#' and '#endDate#'
Order by rpa."x_Is_Tribal";
