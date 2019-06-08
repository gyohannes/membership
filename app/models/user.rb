class User < ApplicationRecord
  has_one :person
  belongs_to :organization_unit, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def super_admin?
    organization_unit == OrganizationUnit.top_organization_unit
  end

  def parent_org_unit
    !institution.blank? ? OrganizationUnit.top_organization_unit : organization_unit
  end

  def admin_status
    admin? ? 'Yes' : ''
  end

  def to_s
    person
  end

end
