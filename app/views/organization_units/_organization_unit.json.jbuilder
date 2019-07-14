json.extract! organization_unit, :id, :name, :short_name, :url, :organization_type_id, :parent_organization_unit_id, :latitude, :longtitude, :created_at, :updated_at
json.url organization_unit_url(organization_unit, format: :json)
