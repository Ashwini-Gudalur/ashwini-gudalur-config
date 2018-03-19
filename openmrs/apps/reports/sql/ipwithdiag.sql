SELECT rp.name,rp.ref,rpa.address2 as address1, rpt."x_Is_Tribal",spe.gender,
  date_part('year',age(spe.birthdate)) as age, sv.diagnoses,
  cast(sv.visit_startdate as date) as admitdate,cast(sv.visit_stopdate as date) as dischargedate from syncjob_visit sv
  LEFT JOIN res_partner_address rpa on sv.erp_patient_id=rpa.partner_id
  LEFT JOIN syncjob_patient_extn spe on spe.erp_id = sv.erp_patient_id
  LEFT JOIN res_partner rp on rp.id = sv.erp_patient_id
  LEFT JOIN res_partner_attributes rpt on rpt.partner_id = sv.erp_patient_id
  LEFT JOIN visit_so_payment_rln t on t.visit_id = sv.id
where sv.visit_type_id=1  and cast(sv.visit_stopdate as DATE) BETWEEN '#startDate#' and '#endDate#'
GROUP BY sv.visit_uuid,rp.ref,rp.name,rpa.address2,sv.diagnoses, admitdate, dischargedate,sv.visit_startdate,
spe.gender,rpt."x_Is_Tribal",age
ORDER BY sv.visit_startdate;
