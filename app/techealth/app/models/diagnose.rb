class Diagnose
  include Mongoid::Document
  auto_increment :id_diagnose
  field :name, type: String
  field :symptoms, type: Array
  field :level, type: String
  field :observations, type: String
  field :id_treatments, type: Array
end
