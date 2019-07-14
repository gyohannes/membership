class Facility < ApplicationRecord
  belongs_to :facility_type
  belongs_to :organization_unit
  has_many :people

  validates :organization_unit_id, :name, :ownership, :contact_person, :contact_phone, :contact_email, presence: true

  def to_s
    name
  end

end
