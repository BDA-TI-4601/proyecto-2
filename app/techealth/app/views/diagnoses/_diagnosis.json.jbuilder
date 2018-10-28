json.extract! diagnosis, :id, :name, :symptoms, :id_diagnose, :level, :observations, :id_patient, :created_at, :updated_at
json.url diagnosis_url(diagnosis, format: :json)
