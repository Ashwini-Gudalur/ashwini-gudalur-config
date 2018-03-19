select pi.patient_identifier_id,ps.uuid,pi.identifier,pm.given_name,pm.family_name,MID(pi.identifier,4,4) 
as village from  patient_identifier pi 
INNER JOIN patient pt on pt.patient_id = pi.patient_id
INNER JOIN person ps on ps.person_id = pi.patient_id
INNER JOIN person_name pm on pm.person_id = pi.patient_id
GROUP by pi.patient_identifier_id,pi.uuid,pi.identifier
HAVING village in ( 0814,0817,0818,0822,1102,1103,1105,
1106,1107,1108,1109,1110,
1111,1112,1114,1116,1118,
1120,1121,1122,1124,1125,
1126,1127,1128,1129,1130,
1131,1132,1133,1134,1136,
1137,1138,1139,1140,1141,
1143,1144,1145,1147,1148,
1152,1153,1159,1161);

