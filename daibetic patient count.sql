SELECT Count(DISTINCT
    a1.PATIENT_ID)
FROM
    healthfacts_raw.hf_f_encounter a1
    INNER JOIN healthfacts_raw.hf_f_diagnosis a2 ON a2.encounter_id = a1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis a3 ON a3.diagnosis_id = a2.diagnosis_id
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
    ) AND
    a2.diagnosis_priority =1;
    
SELECT DISTINCT
    a1.PATIENT_ID,
    a2.DIAGNOSIS_ID
FROM
    healthfacts_raw.hf_f_encounter a1
    INNER JOIN healthfacts_raw.hf_f_diagnosis a2 ON a2.encounter_id = a1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis a3 ON a3.diagnosis_id = a2.diagnosis_id
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
    ) AND
    a2.diagnosis_priority =1;