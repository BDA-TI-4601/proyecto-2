class IllnessDiagnosis
  include Mongoid::Document
  field :name, type: String
  field :symptoms, type: String
  field :treatments, type: String
end
