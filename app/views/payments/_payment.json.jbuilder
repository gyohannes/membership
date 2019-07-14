json.extract! payment, :id, :people_id, :mp_year_id, :remark, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)
