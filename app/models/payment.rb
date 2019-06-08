class Payment < ApplicationRecord
  belongs_to :person
  belongs_to :mp_year

  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: ['application/pdf',/\Aimage\/.*\z/]

  def payment_status
    status == nil ? 'Pending Confirmation' : 'Confirmed'
  end
end