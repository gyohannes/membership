class EventApplicant < ApplicationRecord
  belongs_to :person
  belongs_to :event

  def applicant_status
    self.status == nil ? 'Pending' : 'Confirmed'
  end
end
