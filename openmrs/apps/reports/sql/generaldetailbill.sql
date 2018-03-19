SELECT
  ROW_NUMBER()
  OVER (
  ORDER BY rp.ref ) AS "Sl No",
  rp.ref,
  so.dispensed_location,
  so.create_date,
  rp.name,
  so.name AS "Sale order Number",
  trim(to_char(avl.amount, '9999990.99')) AS "Collected",
  (CASE WHEN rpa."x_Is_Tribal" = 'False'
    THEN 'Non Tribe'
   ELSE 'Tribe' END) AS Caste
FROM account_voucher av
  LEFT JOIN account_voucher_line avl ON avl.voucher_id = av.id
  LEFT JOIN account_move_line aml ON avl.move_line_id = aml.id
  LEFT JOIN res_partner_attributes rpa ON rpa.partner_id = av.partner_id
  LEFT JOIN sale_order so ON so.name = aml.ref
  LEFT JOIN res_partner rp ON rp.id = so.partner_id
  LEFT JOIN sale_order_line sol ON sol.order_id = so.id
  LEFT JOIN product_product pp ON sol.product_id = pp.id
  LEFT JOIN product_template pt ON pp.product_tmpl_id = pt.id
WHERE pt.categ_id  in (549) and pt.categ_id not in(535)
      AND pt.categ_id IS NOT NULL
      AND so.shop_id in (8,2)
      AND av.amount > 0 AND avl.amount > 0 AND av.state = 'posted' AND so.care_setting = 'opd'
      AND cast(av.date_string AS DATE) BETWEEN '#startDate#' and '#endDate#'
      GROUP by so.name,rp.ref,so.dispensed_location,so.create_date,rp.name,avl.amount,rpa."x_Is_Tribal"
UNION ALL
SELECT
  ROW_NUMBER()
  OVER (
  ORDER BY rp.ref ) AS "Sl No",
  rp.ref,
  so.dispensed_location,
  so.create_date,
  rp.name,
  so.name AS "Sale order Number",
  trim(to_char(avl.amount, '9999990.99')) AS "Collected",
  (CASE WHEN rpa."x_Is_Tribal" = 'False'
    THEN 'Non Tribe'
   ELSE 'Tribe' END) AS Caste
FROM account_voucher av
  LEFT JOIN account_voucher_line avl ON avl.voucher_id = av.id
  LEFT JOIN account_move_line aml ON avl.move_line_id = aml.id
  LEFT JOIN res_partner_attributes rpa ON rpa.partner_id = av.partner_id
  LEFT JOIN sale_order so ON so.name = aml.ref
  LEFT JOIN res_partner rp ON rp.id = so.partner_id
  LEFT JOIN sale_order_line sol ON sol.order_id = so.id
  LEFT JOIN product_product pp ON sol.product_id = pp.id
  LEFT JOIN product_template pt ON pp.product_tmpl_id = pt.id
WHERE pt.categ_id  in (550) and pt.categ_id not in(535)
      AND pt.categ_id IS NOT NULL
      AND so.shop_id in (8,2)
      AND av.amount > 0 AND avl.amount =30 AND av.state = 'posted' AND so.care_setting = 'opd'
      AND cast(av.date_string AS DATE) BETWEEN '#startDate#' and '#endDate#'
      GROUP by so.name,rp.ref,so.dispensed_location,so.create_date,rp.name,avl.amount,rpa."x_Is_Tribal"
UNION ALL
SELECT
  ROW_NUMBER()
  OVER (
  ORDER BY rp.ref ) AS "Sl No",
  rp.ref,
  so.dispensed_location,
  so.create_date,
  rp.name,
  so.name AS "Sale order Number",
  trim(to_char(avl.amount, '-9990.99')) AS "Collected",
  (CASE WHEN rpa."x_Is_Tribal" = 'False'
    THEN 'Non Tribe'
   ELSE 'Tribe' END) AS Caste
FROM account_voucher av
  LEFT JOIN account_voucher_line avl ON avl.voucher_id = av.id
  LEFT JOIN account_move_line aml ON avl.move_line_id = aml.id
  LEFT JOIN res_partner_attributes rpa ON rpa.partner_id = av.partner_id
  LEFT JOIN sale_order so ON so.name = aml.ref
  LEFT JOIN res_partner rp ON rp.id = so.partner_id
  LEFT JOIN sale_order_line sol ON sol.order_id = so.id
  LEFT JOIN product_product pp ON sol.product_id = pp.id
  LEFT JOIN product_template pt ON pp.product_tmpl_id = pt.id
WHERE pt.categ_id  in (549) and pt.categ_id not in(535)
      AND pt.categ_id IS NOT NULL
      AND so.shop_id in (8,2)
      AND av.amount < 0 AND avl.amount > 0 AND av.state = 'posted' AND so.care_setting = 'opd'
      AND cast(av.date_string AS DATE) BETWEEN '#startDate#' and '#endDate#'
      GROUP by so.name,rp.ref,so.dispensed_location,so.create_date,rp.name,avl.amount,rpa."x_Is_Tribal";
