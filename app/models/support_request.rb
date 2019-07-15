class SupportRequest < ApplicationRecord
  belongs_to :user
  belongs_to :organization_unit
  has_many :comments
end
