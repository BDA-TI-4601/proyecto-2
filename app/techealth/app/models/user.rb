class User
  include Mongoid::Document
  field :id_user, type: Integer
  field :username, type: String
  field :password, type: String
end
