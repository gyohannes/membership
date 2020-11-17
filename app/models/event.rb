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

  def applied(member)
    return !event_applicants.where('member_id = ?', member).blank?
  end

  def application_status(member)
    if applied(member)
      event_applicants.where('person_id = ?', member).first.status==true ? 'Accepted' : 'Pending'
    end
  end
end
