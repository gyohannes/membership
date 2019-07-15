class Event < ApplicationRecord
  belongs_to :user
  has_many :event_applicants

  def event_date
    if start_date.to_date == end_date.to_date
      return start_date.strftime("%B %d, %Y")
    else
      return start_date.strftime("%B %d, %Y") + ' - ' + end_date.strftime("%B %d, %Y")
    end
  end

  def applied(person)
    return !event_applicants.where('person_id = ?', person).blank?
  end

  def application_status(person)
    if applied(person)
      event_applicants.where('person_id = ?', person).first.status==true ? 'Accepted' : 'Pending'
    end
  end
end
