select rp.ref,rp.name,spe.gender,rpa.city_village as address1,
      cast(sv.visit_startdate as date) as "Start Date", cast(sv.visit_stopdate as date) as "Stop Date",
      case when sv.diagnoses IS NULL then ''
      else sv.diagnoses END ,
      date_part('year',age(spe.birthdate)) as age,get_specific_amount (sv.erp_patient_id, sv.visit_startdate,sv.visit_stopdate, 'Investigations') investigations,
       get_specific_amount (sv.erp_patient_id,sv.visit_startdate,sv.visit_stopdate, 'Others') others,
       get_specific_amount (sv.erp_patient_id, sv.visit_startdate,sv.visit_stopdate, 'Medicines') Medicines,
       get_specific_amount (sv.erp_patient_id, sv.visit_startdate,sv.visit_stopdate, 'Procedure') procedures,
       get_amountsa(sv.erp_patient_id, sv.visit_startdate,sv.visit_stopdate) total
       from syncjob_visit sv
  INNER JOIN syncjob_patient_extn spe on spe.erp_id=sv.erp_patient_id  AND
                                                 sv.visit_type_id=1 and cast(sv.visit_stopdate as date) BETWEEN '#startDate#' and '#endDate#'
  INNER JOIN res_partner rp on rp.id=sv.erp_patient_id
  inner join res_partner_attributes rpat on rpat.partner_id=sv.erp_patient_id 
  inner JOIN res_partner_address rpa on rp.id = rpa.partner_id
    Order by sv.visit_startdate;

