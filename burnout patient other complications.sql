select Distinct
b1.patient_id,
b2.diagnosis_priority,
b3.diagnosis_code,
CASE
when b3.diagnosis_description like '%Kidney%' or b3.diagnosis_description like'%Nephropathy%' THEN 'KIDNEY'
when b3.diagnosis_description like 'Hypertensive Heart and Chronic Kidney%' THEN 'HEART_KIDNEY'
when b3.diagnosis_description like '%retinopathy%'  OR b3.diagnosis_description like '%EYE%' THEN 'EYE'
when b3.diagnosis_description like '%Foot%' THEN 'Foot'
when b3.diagnosis_description like '%Skin%' THEN 'Skin'
when b3.diagnosis_description like '%Hypertension%' THEN 'Hypertension'
when b3.diagnosis_description like '%diabetes%' THEN 'diabetes'
when b3.diagnosis_description like '%Hearing%' THEN 'Hearing'
when b3.diagnosis_description like '%Hearing%' THEN 'Hearing'
when b3.diagnosis_description like '%neuropathy%' OR b3.diagnosis_description like '%nerve%' THEN 'Neuropathy'
when b3.diagnosis_description like '%Alzheimer%' THEN 'Alzheimer'
when b3.diagnosis_description like '%Cardiovascular%' OR b3.diagnosis_description like '%atherosclerosis%' 
or b3.diagnosis_description like '%angina%' or b3.diagnosis_description like '%Heart%'THEN 'Heart'
ELSE 'Other'
END as complication_category,
b3.diagnosis_description
from
healthfacts_raw.hf_f_encounter b1
INNER JOIN healthfacts_raw.hf_f_diagnosis b2 ON b2.encounter_id = b1.encounter_id
INNER JOIN healthfacts_raw.hf_d_diagnosis b3 ON b3.diagnosis_id = b2.diagnosis_id
where b1.encounter_id in
(SELECT DISTINCT
    a1.encounter_id
FROM
    healthfacts_raw.hf_f_encounter a1
    INNER JOIN healthfacts_raw.hf_f_diagnosis a2 ON a2.encounter_id = a1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis a3 ON a3.diagnosis_id = a2.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history a4 ON a4.encounter_id = a1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status a5 ON a5.compliance_status_id = a4.compliance_status_id
WHERE
    (
            a3.diagnosis_code LIKE ( '250.%' )
        OR
            a3.diagnosis_code = '250'
        OR
            a3.diagnosis_code LIKE ( 'E10.%' )
        OR
            a3.diagnosis_code = 'E10'
        OR
            a3.diagnosis_code = 'E11'
        OR
            a3.diagnosis_code LIKE ( 'E11.%' )
    ) AND (
            a5.compliance_status_id = 8
        OR
            a5.compliance_status_id = 13
    )AND
    a2.diagnosis_priority =1)
    AND b2.diagnosis_priority > 1;