class Treatment
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :dosis, type: String
  field :total, type: Integer
end
