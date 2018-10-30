class Administrator
  include Mongoid::Document
  field :treatment, type: String
  field :amount, type: Integer
  field :price, type: Integer
end
