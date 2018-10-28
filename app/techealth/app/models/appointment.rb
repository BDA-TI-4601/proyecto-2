class Appointment
  include Mongoid::Document
  auto_increment :id_appointment
  field :area, type: String
  field :observations, type: String
  field :status, type: String
  field :app_date, type: Time
  field :id_diagnoses, type: Array
end
