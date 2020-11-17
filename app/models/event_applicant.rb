class EventApplicant < ApplicationRecord
  belongs_to :member
  belongs_to :event

  def applicant_status
    self.status == nil ? 'Pending' : 'Confirmed'
  end
end
