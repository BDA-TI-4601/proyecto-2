json.extract! illness_diagnosis, :id, :name, :symptoms, :treatments, :created_at, :updated_at
json.url illness_diagnosis_url(illness_diagnosis, format: :json)
