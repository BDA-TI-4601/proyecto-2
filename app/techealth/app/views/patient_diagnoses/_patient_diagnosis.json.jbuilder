json.extract! patient_diagnosis, :id, :id_patient, :diagnose_id, :level, :observation, :created_at, :updated_at
json.url patient_diagnosis_url(patient_diagnosis, format: :json)
