class User
  include Mongoid::Document
  field :id, type: Integer
  field :username, type: String
  field :password, type: String
end
