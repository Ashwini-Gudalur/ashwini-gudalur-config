SELECT ROW_NUMBER() OVER (ORDER BY so.name) as "Sl No",cast(so.create_date as date),rp.ref,rp.name,so.name as "Sale order Number",
trim(to_char(so.amount_untaxed,'9999990.99')) as "Total billed",trim(to_char(so.amount_tax,'9999990.99')) as Tax,
trim(to_char(so.discount, '9999990.99')) as "discount",trim(to_char(so.amount_total, '9999990.99')) as "Paid",(case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
else 'Tribe' END) as Caste from sale_order so
LEFT JOIN res_partner_attributes rpa on rpa.partner_id=so.partner_id
LEFT JOIN res_partner rp on rp.id = so.partner_id
WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
  WHERE product_id IN(SELECT pp.id FROM product_product pp INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
  WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping WHERE chargetype_name = 'Medicines')))
  and so.state!='draft' AND so.care_setting = 'opd'
and rpa."x_patientcategory" like 'Sickle%' 
and cast(so.create_date as DATE) BETWEEN '#startDate#' and '#endDate#'
Order by so.name;
