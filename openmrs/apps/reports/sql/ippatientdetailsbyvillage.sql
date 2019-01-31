SELECT rp.name,rp.ref,rpa.address2 As Area,rpa.city_village As Village,spe.gender,rpt."x_Tribe" as "Tribe type",
  	date_part('year',age(spe.birthdate)) As age,
  CASE WHEN rpt."x_Is_Tribal" = 'True' then 'Tribal'
  	ELSE 'Non tribal' END As Tribal,
  CASE WHEN rpt."x_Is_Sangam" = 'True' then 'Sangam' 
  	ELSE 'Non sangam' END As sangam,
  CASE WHEN rpt."x_Is_Premium_Paid" = 'True' then 'Paid'
  	ELSE 'Not paid' END As Premium,
  	sv.diagnoses,
  	sv.visit_startdate As admitdate,sv.visit_stopdate As dischargedate,
  	sum(t.amount_total+t.discount_amount) billed,sum(paid) paid from syncjob_visit sv
  LEFT JOIN res_partner_address rpa on sv.erp_patient_id=rpa.partner_id
  LEFT JOIN syncjob_patient_extn spe on spe.erp_id = sv.erp_patient_id
  LEFT JOIN res_partner rp on rp.id = sv.erp_patient_id
  LEFT JOIN res_partner_attributes rpt on rpt.partner_id = sv.erp_patient_id
  LEFT JOIN visit_so_payment_rln t on t.visit_id = sv.id
WHERE 	 sv.visit_type_id=1 and cast(sv.visit_stopdate As DATE) BETWEEN '#startDate#' and '#endDate#'
GROUP BY sv.visit_uuid,rp.ref,rp.name,rpa.address2,sv.diagnoses, admitdate, dischargedate,
rpa.city_village,spe.gender,rpt."x_Is_Tribal",age,rpt."x_Is_Sangam",rpt."x_Is_Premium_Paid",rpt."x_Tribe"
ORDER BY rpa.address2;
