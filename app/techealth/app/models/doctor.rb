class Doctor
  include Mongoid::Document
  field :id_appointment, type: Integer
  field :area, type: String
  field :app_date, type: Time
  field :observation, type: String
  field :status, type: String
  field :id_patient_integer, type: String
  field :id_diagnoses, type: Array
end
