json.extract! appointment, :id, :id_appointment, :area, :app_date, :observation, :status, :id_patient, :id_diagnoses, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
