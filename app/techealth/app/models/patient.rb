class Patient
  include Mongoid::Document
  field :id_patient, type: Integer
  field :name, type: String
  field :birth_date, type: Date
  field :blood, type: String
  field :nationality, type: String
  field :residence, type: String
  field :telephone, type: Array
end
