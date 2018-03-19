SELECT so.care_setting,
(case when ct.claim_type = '1' then 'Sickle Cell'
       when ct.claim_type = '2' then 'Bed Grant'
       else 'General/CMCHIS' end) as claim,
 (case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
          else 'Tribe' END) as Caste,
trim(to_char(sum(so.amount_total), '9999990.99')) as "Billed",
trim(to_char(sum(discount_amount), '9999990.99')) as "Charity"
FROM  sale_order so
LEFT JOIN claim_type ct on ct.erp_patient_id = so.partner_id
LEFT JOIN res_partner rp on rp.id = so.partner_id
LEFT JOIN res_partner_attributes rpa on rp.id = rpa.partner_id
WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
WHERE product_id IN(
SELECT pp.id
FROM product_product pp
INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
inner join sale_order so1 on sol.order_id = so1.id
WHERE pt.categ_id IN (select category_id
from syncjob_chargetype_category_mapping
WHERE chargetype_name = 'Medicines')
and cast(so1.write_date as date) BETWEEN '#startDate#' and '#endDate#'
                AND (sol.state = 'confirmed' or sol.state ='done')))
AND cast(so.write_date as date) BETWEEN '#startDate#' and '#endDate#'
GROUP BY so.care_setting,
         ct.claim_type,
         rpa."x_Is_Tribal"
ORDER BY so.care_setting;

