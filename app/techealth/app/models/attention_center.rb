class AttentionCenter
  include Mongoid::Document
  auto_increment :code
  field :name, type: String
  field :place, type: String
  field :capacity, type: Integer
  field :center_type, type: String
end
