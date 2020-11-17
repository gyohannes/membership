json.extract! cpd_course, :id, :cpd_provider_id, :activity_title, :method_of_delivery, :date_of_activity, :target_audience, :venue_of_activity, :registration_fee_involved_for_participants, :duration_of_the_learning_activity, :suggested_ceu, :ethics, :mechanism_for_monitoring, :mechanism_for_monitoring_attendance, :created_at, :updated_at
json.url cpd_course_url(cpd_course, format: :json)
