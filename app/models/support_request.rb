class SupportRequest < ApplicationRecord
  #belongs_to :sender, :class_name => 'User', :foreign_key => "sender_id"
  #belongs_to :receiver, :class_name => 'User', :foreign_key => "receiver_id"
  belongs_to :parent_request, optional: true, :class_name => 'SupportRequest', :foreign_key => "parent_request_id"
  has_many :comments, :class_name => 'SupportRequest', :foreign_key => "parent_request_id"

  def sender_user
    User.find_by(id: sender).to_s
  end

  def receiver_user
    User.find_by(id: receiver).to_s
  end

  def to_s
    sender.to_s
  end
end
