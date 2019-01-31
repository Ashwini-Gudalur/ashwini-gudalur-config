SELECT rp.name,rp.ref,rpa.address2,rpa.address1,rpt."x_Tribe" as "Tribe type",
   CASE WHEN rpt."x_Is_Tribal" = 'True' then 'Tribal'
    ELSE 'Non tribal' END As Tribal,
  CASE WHEN rpt."x_Is_Sangam" = 'True' then 'Sangam' 
    ELSE 'Non sangam' END As sangam,
  CASE WHEN rpt."x_Is_Premium_Paid" = 'True' then 'Paid'
    ELSE 'Not paid' END As Premium,
  spe.gender,
  date_part('year',age(spe.birthdate)) as age, sv.diagnoses,
  sv.visit_startdate as admitdate,sv.visit_stopdate as dischargedate,
  sum(t.amount_total+t.discount_amount) billed,sum(paid) paid from syncjob_visit sv
  INNER JOIN res_partner_address rpa on sv.erp_patient_id=rpa.partner_id
  INNER JOIN syncjob_patient_extn spe on spe.erp_id = sv.erp_patient_id
  INNER JOIN res_partner rp on rp.id = sv.erp_patient_id
  INNER JOIN res_partner_attributes rpt on rpt.partner_id = sv.erp_patient_id
  INNER JOIN visit_so_payment_rln t on t.visit_id = sv.id
where sv.visit_type_id=1 and cast(sv.visit_stopdate as DATE) between '#startDate#' and '#endDate#'
GROUP BY sv.visit_uuid,rp.ref,rp.name,rpa.address2,rpa.address1,sv.diagnoses, admitdate, dischargedate,
  spe.gender,rpt."x_Is_Tribal",age,rpt."x_Is_Sangam",rpt."x_Is_Premium_Paid",rpt."x_Tribe"
ORDER BY sv.visit_startdate;
