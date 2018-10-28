class Appointment
  include Mongoid::Document
  field :area, type: String
  field :app_date, type: Date
  field :observation, type: String
  autoincremental :id_app
  field :status, type: String
  field :id_patient, type: Integer
end
