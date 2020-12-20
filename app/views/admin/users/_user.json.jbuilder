json.extract! user, :id, :email, :admin, :name, :last_name, :provider, :uid, :created_at, :updated_at
json.url user_url(user, format: :json)
