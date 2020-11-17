class Institution < ApplicationRecord
  belongs_to :member
  belongs_to :organization_unit

  has_one_attached :logo
  has_one_attached :certificate

  def region
    organization_unit.parent_organization_unit.parent_organization_unit unless organization_unit.blank?
  end

  def zone
    organization_unit.parent_organization_unit unless organization_unit.blank?
  end

  def woreda
    organization_unit
  end

  def region_zone_woreda
    [region, zone, woreda].join(' - ')
  end
end
