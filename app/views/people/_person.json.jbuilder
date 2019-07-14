json.extract! person, :id, :user_id, :first_name, :middle_name, :last_name, :emial, :phone_number, :address, :country, :institution_id, :facility_id, :created_at, :updated_at
json.url person_url(person, format: :json)
