class Secretary
  include Mongoid::Document
  field :id_appointment, type: Integer
  field :area, type: String
  field :app_date, type: Time
  field :observation, type: String
  field :status, type: String
  field :id_patient, type: Integer
end
