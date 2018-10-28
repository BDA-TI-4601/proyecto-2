class Login
  include Mongoid::Document
  field :username, type: String
  field :password, type: String
end
