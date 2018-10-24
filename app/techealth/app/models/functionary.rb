class Functionary
  include Mongoid::Document
  field :name, type: String
  field :init_date, type: String
  field :area, type: String
  field :id_functionary, type: String
  field :type, type: String
end
