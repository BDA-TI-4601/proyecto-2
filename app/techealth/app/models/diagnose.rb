class Diagnose
  include Mongoid::Document
  field :name, type: String
  field :symptoms, type: String
  auto_increment :id_diagnose
  field :level, type: String
  field :observations, type: String
  field :id_patient, type: Integer
end
