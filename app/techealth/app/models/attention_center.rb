class AttentionCenter
  include Mongoid::Document
  field :code, type: Integer
  field :name, type: String
  field :place, type: String
  field :capacity, type: Integer
  field :center_type, type: String
end
