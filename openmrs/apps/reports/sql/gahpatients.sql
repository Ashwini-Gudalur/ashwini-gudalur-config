select pi.patient_id,pi.identifier,pn.given_name,pn.family_name,pa.address1,pa.address2,pa.city_village
from patient_identifier pi
inner join person_name pn on pn.person_id=pi.patient_id
inner join person_address pa on pa.person_id=pi.patient_id
where pi.identifier like 'TRI%';
