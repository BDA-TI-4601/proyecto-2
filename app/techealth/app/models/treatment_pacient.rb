class TreatmentPacient
  include Mongoid::Document
  field :id_patient, type: Integer
  field :dosis, type: String
  field :days, type: Integer
  field :secundary_effects, type: String
end
