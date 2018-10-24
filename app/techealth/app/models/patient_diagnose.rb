class PatientDiagnose
  include Mongoid::Document
  field :id_patient, type: Integer
  field :diagnose_id, type: Integer
  field :level, type: String
  field :observation, type: String
end
