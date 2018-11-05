json.extract! user, :id, :id_user, :username, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
