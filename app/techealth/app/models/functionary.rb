class Functionary
  include Mongoid::Document
  field :name, type: String
  field :init_date, type: Date
  field :area, type: String
  field :id_functionary, type: String
  field :type, type: String
end
