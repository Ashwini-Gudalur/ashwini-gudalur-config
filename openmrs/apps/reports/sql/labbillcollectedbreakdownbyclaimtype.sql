SELECT 
    (case when ct.claim_type = '1' then 'Sickle Cell'
       when ct.claim_type = '2' then 'Bed Grant'
       else 'General/CMCHIS' end) as claim,
    (case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
      else 'Tribe' END) as Caste,
    so.care_setting,
    trim(to_char(sum(ai.amount_total), '9999990.99')) as "Collected"
  FROM sale_order so
  LEFT JOIN account_invoice ai on so.name = ai.origin
  LEFT JOIN account_voucher av on av.invoice_id = ai.id
  LEFT JOIN res_partner_attributes rpa on rpa.partner_id=so.partner_id
  LEFT JOIN claim_type ct on ct.erp_patient_id = so.partner_id
  WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
  WHERE product_id IN(SELECT pp.id FROM product_product pp INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id
  WHERE pt.categ_id IN (select category_id from syncjob_chargetype_category_mapping WHERE chargetype_name = 'Investigations')))
  AND ai.state = 'paid'
  AND cast(so.write_date as date) BETWEEN '#startDate#' and '#endDate#'
  GROUP by ct.claim_type,rpa."x_Is_Tribal",so.care_setting;
