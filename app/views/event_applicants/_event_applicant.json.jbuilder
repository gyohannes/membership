json.extract! event_applicant, :id, :person_id, :event_id, :status, :created_at, :updated_at
json.url event_applicant_url(event_applicant, format: :json)
