json.extract! appointment, :id, :area, :app_date, :observation, :id_app, :status, :id_patient, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
