class Appointment
  include Mongoid::Document
  auto_increment :id_appointment
  field :area, type: String
  field :app_date, type: Time
  field :observation, type: String
  field :status, type: String
  field :id_patient, type: Integer
  field :id_diagnoses, type: Array
end
