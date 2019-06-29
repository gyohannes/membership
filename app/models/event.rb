class Event < ApplicationRecord
  belongs_to :user

  def event_date
    if start_date.to_date == end_date.to_date
      return start_date.strftime("%B %d, %Y")
    else
      return start_date.strftime("%B %d, %Y") + ' - ' + end_date.strftime("%B %d, %Y")
    end
  end
end
