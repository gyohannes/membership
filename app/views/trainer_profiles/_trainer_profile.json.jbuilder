json.extract! trainer_profile, :id, :person_id, :trainer_type, :primary_job, :secondary_job, :created_at, :updated_at
json.url trainer_profile_url(trainer_profile, format: :json)
