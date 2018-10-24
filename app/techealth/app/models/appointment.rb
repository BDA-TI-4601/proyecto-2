class Appointment
  include Mongoid::Document
  field :area, type: String
  field :app_date, type: String
  field :hour, type: String
  field :observation, type: String
  field :id, type: Integer
  field :status, type: String
end
