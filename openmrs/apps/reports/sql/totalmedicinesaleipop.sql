SELECT 
so.care_setting,
(case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
else 'Tribe' END) as Caste,
trim(to_Char(sum(so.amount_tax+so.amount_untaxed),'9999990.99')) as "Total Billed",
trim(to_Char(sum(so.discount),'9999990.99')) as "discount",
trim(to_Char(sum(so.amount_total),'9999990.99')) as Total
from sale_order so   
INNER JOIN res_partner rp on rp.id = so.partner_id
INNER JOIN res_partner_attributes rpa on rp.id = rpa.partner_id
WHERE so.id in (SELECT distinct(sol.order_id) 
                FROM sale_order_line sol
WHERE sol.product_id IN(SELECT pp.id FROM product_product pp 
                        INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping 
                      WHERE chargetype_name = 'Medicines')))
and (so.state!='cancel' or so.state!='draft') 
and cast(so.date_confirm as DATE) BETWEEN '#startDate#' and '#endDate#'
group by rpa."x_Is_Tribal",
             so.care_setting;
