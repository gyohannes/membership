json.extract! association_detail, :id, :name, :short_name, :contact_phone, :contact_email, :address, :created_at, :updated_at
json.url association_detail_url(association_detail, format: :json)
