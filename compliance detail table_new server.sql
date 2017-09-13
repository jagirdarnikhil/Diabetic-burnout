SELECT DISTINCT
    b1.patient_id,
    b1.encounter_id,
    b3.patient_sk,
    b3.gender,
    b3.race,
    b3.marital_status,
    b8.diagnosis_priority,
    b9.diagnosis_code,
    b5.year AS admit_yr,
    b5.month AS admit_month,
    b6.year AS disc_yr,
    b6.month AS disc_month,
    b4.dischg_disp_code_desc,
    b12.compliance_desc,
    b7.payer_code_desc,
    b15.lab_procedure_mnemonic,
    b15.lab_procedure_group,
    b14.normal_range_low,
    b14.normal_range_high,
    b16.result_indicator_desc,
    b17.med_cancel_reason_desc,
    (b2.unit_price*b2.charge_quantity) as medication_cost
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_f_medication b2 ON b2.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_d_dischg_disp b4 ON b4.dischg_disp_id = b1.discharge_disposition_id
    INNER JOIN healthfacts_raw.hf_d_date b5 ON b1.admitted_dt_id = b5.date_id
    INNER JOIN healthfacts_raw.hf_d_date b6 ON b1.discharged_dt_id = b6.date_id
    INNER JOIN healthfacts_raw.hf_d_payer b7 ON b7.payer_id = b1.payer_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
    INNER JOIN healthfacts_raw.hf_f_lab_procedure b14 ON b14.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_lab_procedure b15 ON b14.detail_lab_procedure_id = b15.lab_procedure_id
    INNER JOIN healthfacts_raw.hf_d_result_indicator b16 ON b14.result_indicator_id = b16.result_indicator_id
    INNER JOIN healthfacts_raw.hf_d_med_cancel_reason b17 ON b17.med_cancel_reason_id = b10.med_reason_id
WHERE
    (
            b9.diagnosis_code LIKE ( '250.%' )
        OR
            b9.diagnosis_code = '250'
        OR
            b9.diagnosis_code LIKE ( 'E10.%' )
        OR
            b9.diagnosis_code = 'E10'
        OR
            b9.diagnosis_code = 'E11'
        OR
            b9.diagnosis_code LIKE ( 'E11.%' )
    ) AND
        b12.compliance_status_id BETWEEN 5 AND 15;
        
SELECT DISTINCT
    b1.patient_id,
    b1.encounter_id,
    b3.patient_sk,
    b3.gender,
    b3.race,
    b3.marital_status,
    b5.year AS admit_yr,
    b5.month AS admit_month,
    b6.year AS disc_yr,
    b6.month AS disc_month,
    b4.dischg_disp_code_desc,
    b12.compliance_desc,
    b7.payer_code_desc,
    b1.age_in_years
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_d_dischg_disp b4 ON b4.dischg_disp_id = b1.discharge_disposition_id
    INNER JOIN healthfacts_raw.hf_d_date b5 ON b1.admitted_dt_id = b5.date_id
    INNER JOIN healthfacts_raw.hf_d_date b6 ON b1.discharged_dt_id = b6.date_id
    INNER JOIN healthfacts_raw.hf_d_payer b7 ON b7.payer_id = b1.payer_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
WHERE
    (
            b9.diagnosis_code LIKE ( '250.%' )
        OR
            b9.diagnosis_code = '250'
        OR
            b9.diagnosis_code LIKE ( 'E10.%' )
        OR
            b9.diagnosis_code = 'E10'
        OR
            b9.diagnosis_code = 'E11'
        OR
            b9.diagnosis_code LIKE ( 'E11.%' )
    ) AND
        b12.compliance_status_id BETWEEN 5 AND 15;
