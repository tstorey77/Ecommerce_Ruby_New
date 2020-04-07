json.extract! user, :id, :username, :password, :email, :provinces_id, :created_at, :updated_at
json.url user_url(user, format: :json)
