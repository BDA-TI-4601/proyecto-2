json.extract! diagnosis, :id, :id_diagnose, :name, :symptoms, :level, :observations, :id_treatments, :created_at, :updated_at
json.url diagnosis_url(diagnosis, format: :json)
