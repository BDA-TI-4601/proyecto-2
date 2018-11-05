class Functionary
  include Mongoid::Document
  field :name, type: String
  field :init_date, type: Date
  field :area, type: String
  field :identification, type: Integer
  field :type, type: String
  field :institution, type: String
end
