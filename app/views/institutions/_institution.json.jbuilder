json.extract! institution, :id, :name, :institution_type_id, :address, :url, :contact_person, :email, :phone, :created_at, :updated_at
json.url institution_url(institution, format: :json)
