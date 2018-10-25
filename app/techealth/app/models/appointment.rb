class Appointment
  include Mongoid::Document
  field :area, type: String
  field :app_date, type: Date
  field :hour, type: Time
  field :observation, type: String
  field :id, type: Integer
  field :status, type: String
end
