json.extract! event, :id, :person_id, :title, :start_date, :end_date, :maximum_participants, :event_details, :status, :created_at, :updated_at
json.url event_url(event, format: :json)
