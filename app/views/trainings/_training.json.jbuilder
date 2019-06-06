json.extract! training, :id, :training_title_id, :start_time, :end_time
json.title training.training_title.title
json.start training.start_time
json.end training.end_time + 1 rescue nil
json.url training_url(training, format: :html)
