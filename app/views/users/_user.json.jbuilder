json.extract! user, :id, :user_name, :email, :organization_unit_id, :role_id, :password, :password_confirmation, :created_at, :updated_at
json.url user_url(user, format: :json)
