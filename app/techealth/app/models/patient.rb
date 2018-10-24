class Patient
  include Mongoid::Document
  field :id, type: Integer
  field :name, type: String
  field :birth_date, type: String
  field :blood, type: String
  field :nationality, type: String
  field :residence, type: String
  field :telephone, type: Array
end
