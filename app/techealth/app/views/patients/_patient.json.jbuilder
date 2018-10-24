json.extract! patient, :id, :id, :name, :birth_date, :blood, :nationality, :residence, :telephone, :created_at, :updated_at
json.url patient_url(patient, format: :json)
