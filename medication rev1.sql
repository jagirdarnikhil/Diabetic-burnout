SELECT DISTINCT
    b1.patient_id,
    b1.encounter_id,
    b3.patient_sk,
    b1.age_in_years,
    b3.race,
    b3.gender,
    b3.marital_status,
    b1.weight,
    b1.admitted_dt_tm,
    b2.med_discontinued_dt_tm,
    b1.discharged_dt_tm,
    b11.med_cancel_reason_desc,
    b12.compliance_desc,
    b2.unit_cost,
    b2.charge_quantity,
    b2.credit_quantity,
    ( b2.unit_cost * b2.charge_quantity ) AS medication_cost,
    b8.diagnosis_priority,
    b9.diagnosis_description,
    b9.diagnosis_code
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_f_medication b2 ON b1.encounter_id = b2.encounter_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_med_cancel_reason b11 ON b11.med_cancel_reason_id = b10.med_reason_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
WHERE
b9.DIAGNOSIS_CODE like ('250.%')
or b9.DIAGNOSIS_CODE= '250'
or b9.DIAGNOSIS_CODE like ('E10.%')
or b9.DIAGNOSIS_CODE='E10'
or b9.DIAGNOSIS_CODE = 'E11'
or b9.DIAGNOSIS_CODE like ('E11.%')
        AND 
        b12.COMPLIANCE_STATUS_ID between 6 and 15;
        
select b1.encounter_id, b1.DIAGNOSIS_PRIORITY,b2.DIAGNOSIS_CODE, b2.DIAGNOSIS_DESCRIPTION
from healthfacts_raw.hf_f_diagnosis b1 join healthfacts_raw.hf_d_diagnosis b2 on b1.diagnosis_id = b2.diagnosis_id
where 
b2.DIAGNOSIS_CODE like ('250.%')
or b2.DIAGNOSIS_CODE= '250'
or b2.DIAGNOSIS_CODE like ('E10.%')
or b2.DIAGNOSIS_CODE='E10'
or b2.DIAGNOSIS_CODE = 'E11'
or b2.DIAGNOSIS_CODE like ('E11.%')

SELECT DISTINCT
    b1.patient_id,
    b1.encounter_id,
    b3.patient_sk,
    b1.age_in_years,
    b3.race,
    b3.gender,
    b3.marital_status,
    b1.admitted_dt_tm,
    b1.discharged_dt_tm,
    b11.med_cancel_reason_desc,
    b12.compliance_desc,
    b8.diagnosis_priority,
    b9.diagnosis_description,
    b9.diagnosis_code,
    b17.result_indicator_desc,
    b16.lab_procedure_mnemonic,
    b16.lab_procedure_group,
    b14.normal_range_high,
    b14.normal_range_low
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_med_cancel_reason b11 ON b11.med_cancel_reason_id = b10.med_reason_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
    INNER JOIN healthfacts_raw.hf_f_lab_procedure b14 ON b14.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_lab_procedure b16 ON b16.lab_procedure_id = b14.detail_lab_procedure_id
    INNER JOIN healthfacts_raw.hf_d_result_indicator b17 ON b17.result_indicator_id = b14.result_indicator_id
WHERE
    b9.DIAGNOSIS_CODE like ('250.%')
or b9.DIAGNOSIS_CODE= '250'
or b9.DIAGNOSIS_CODE like ('E10.%')
or b9.DIAGNOSIS_CODE='E10'
or b9.DIAGNOSIS_CODE = 'E11'
or b9.DIAGNOSIS_CODE like ('E11.%');

SELECT DISTINCT
    b1.patient_id,
    SUM(b2.unit_cost * b2.charge_quantity) AS medication_cost
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_f_medication b2 ON b1.encounter_id = b2.encounter_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
WHERE
    b12.compliance_status_id = 15
GROUP BY
    b1.patient_id
    
    
SELECT DISTINCT
    b1.patient_id,
    b1.encounter_id,
    b12.compliance_desc
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_med_cancel_reason b11 ON b11.med_cancel_reason_id = b10.med_reason_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
WHERE
b12.compliance_status_id = 6;


SELECT DISTINCT
    b1.patient_id,
    b8.DIAGNOSIS_PRIORITY,
    b9.DIAGNOSIS_CODE
FROM
    healthfacts_raw.hf_f_encounter b1
    INNER JOIN healthfacts_raw.hf_d_patient b3 ON b3.patient_id = b1.patient_id
    INNER JOIN healthfacts_raw.hf_f_medication b2 ON b1.encounter_id = b2.encounter_id
    INNER JOIN healthfacts_raw.hf_f_diagnosis b8 ON b8.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_diagnosis b9 ON b9.diagnosis_id = b8.diagnosis_id
    INNER JOIN healthfacts_raw.hf_f_med_history b10 ON b10.encounter_id = b1.encounter_id
    INNER JOIN healthfacts_raw.hf_d_compliance_status b12 ON b12.compliance_status_id = b10.compliance_status_id
WHERE
    b12.compliance_status_id = 13;

select* from healthfacts_raw.hf_f_encounter b1
where b1.PATIENT_ID= 213439721;