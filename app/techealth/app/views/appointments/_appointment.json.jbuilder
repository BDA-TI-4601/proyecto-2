json.extract! appointment, :id, :id_appointment, :area, :observations, :status, :app_date, :id_diagnoses, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
