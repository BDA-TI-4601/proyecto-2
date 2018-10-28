class Treatment
  include Mongoid::Document
  field :name, type: String
  auto_increment :id_treatment
  field :type, type: String
  field :dosis, type: String
  field :total, type: Integer
  field :secondary_effects, type: String
  field :days, type: Integer
end
