SELECT
    Count(DISTINCT b3.patient_id)
FROM
    healthfacts_raw.hf_f_diagnosis b1
    INNER JOIN healthfacts_raw.hf_d_diagnosis b2 ON b1.diagnosis_id = b2.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_encounter b3 ON b1.encounter_id = b3.encounter_id
    INNER JOIN healthfacts_raw.hf_d_patient b4 ON b3.patient_id = b4.patient_id
WHERE
    b3.encounter_id IN (
        SELECT
            a2.encounter_id
        FROM
            healthfacts_raw.hf_d_diagnosis a1
            INNER JOIN healthfacts_raw.hf_f_diagnosis a2 ON a1.diagnosis_id = a2.diagnosis_id
        WHERE
                a2.diagnosis_priority = 1
            AND
                a1.diagnosis_code LIKE '250.%'
    )
    

SELECT 
    DISTINCT b1.patient_id,
    b1.encounter_id,
    b4.dischg_disp_code,
    b4.dischg_disp_code_desc,
    b6.procedure_code,
    b6.procedure_description,
    b7.diagnosis_priority,
    b7.diagnosis_type_id,
    b8.diagnosis_code,
    b8.diagnosis_description
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_f_procedure b5 ON b5.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_dischg_disp b4 ON b4.dischg_disp_id = b1.discharge_disposition_id
    INNER JOIN healthfacts_raw.hf_d_procedure b6 ON b6.procedure_id = b5.procedure_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b7 ON b7.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b8 ON b8.diagnosis_id = b7.diagnosis_id
WHERE
    b1.encounter_id IN (
        SELECT
            a1.encounter_id
        FROM
            healthfacts_raw.hf_f_diagnosis a1
            INNER JOIN healthfacts_raw.hf_d_diagnosis a2 ON a1.diagnosis_id = a2.diagnosis_id
        WHERE
                a2.diagnosis_code LIKE '250.%'
            AND
                a1.diagnosis_priority = 1
    )
    
Select 
distinct b1.patient_id      
From
healthfacts_raw.hf_f_encounter b1
INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
join healthfacts_raw.hf_f_medication b2 on b1.encounter_id = b2.encounter_id
Where  
 b1.encounter_id IN (
        SELECT
            a1.encounter_id
        FROM
            healthfacts_raw.hf_f_diagnosis a1
            INNER JOIN healthfacts_raw.hf_d_diagnosis a2 ON a1.diagnosis_id = a2.diagnosis_id
        WHERE
                a2.diagnosis_code LIKE '250.%'
            AND
                a1.diagnosis_priority = 1
    )