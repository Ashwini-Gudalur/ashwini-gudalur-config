SELECT
    ROW_NUMBER() OVER (ORDER BY rp.ref) as "Sl No",
    rp.ref,
    so.dispensed_location,
    date(so.create_date),
    rp.name,
    so.name as "Sale order Number",
    (case when rpa."x_Is_Tribal" = 'False' then 'Non Tribe'
     else 'Tribe' END) as Caste,
    trim(to_char(sum(av.amount), '9999990.99')) as "Collected"
  FROM sale_order so
  LEFT JOIN account_invoice ai on so.name = ai.origin
  LEFT JOIN account_voucher av on av.invoice_id = ai.id
  LEFT JOIN res_partner_attributes rpa on rpa.partner_id=so.partner_id
  LEFT JOIN claim_type ct on ct.erp_patient_id = so.partner_id
  LEFT JOIN res_partner rp on rp.id = so.partner_id
  WHERE so.id in (SELECT distinct(sol.order_id) FROM sale_order_line sol
  WHERE product_id IN(SELECT pp.id FROM product_product pp 
  INNER JOIN product_template pt ON pp.product_tmpl_id = pt.id 
  and pt.categ_id = 537))
  AND cast(av.date_string as date) BETWEEN '#startDate#' and '#endDate#'
  GROUP by ct.claim_type,rpa."x_Is_Tribal",ai.state,rp.ref,so.dispensed_location,so.create_date,rp.name,so.name;
