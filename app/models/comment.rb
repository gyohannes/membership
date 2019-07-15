class Comment < ApplicationRecord
  belongs_to :support_request
  belongs_to :user

  after_create :update_support_status

  def update_support_status
    self.support_request.update(status: true)
  end
end
