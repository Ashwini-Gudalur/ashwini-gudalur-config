select  rp.ref as Patient_ID,rp.name as name,rpa.address2 as address,(Case when ct.claim_type = '1' then 'Sickcell' else 'Bed grant' END) as claim_type
from res_partner rp
  inner join claim_type ct on ct.erp_patient_id=rp.id
   inner JOIN res_partner_address rpa on rp.id = rpa.partner_id
   	GROUP BY rp.ref,rp.name,rpa.address2,ct.claim_type; 
