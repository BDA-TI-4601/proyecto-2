class Treatment
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :dosis, type: String
  field :total, type: Integer
  field :id_patient, type: Integer
  field :secundary_effects, type: String
  field :days, type: Integer
end
