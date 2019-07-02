class User < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :facility, optional: true
  has_one :person
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = [ADMIN='Admin', MEMBER='Member', INSTITUTION='Institution']

  def super_admin?
    organization_unit == OrganizationUnit.top_organization_unit
  end

  def has_role(role_name)
    role == role_name
  end
  def admin?
    !organization_unit.blank?
  end

  def parent_org_unit
    !institution.blank? ? OrganizationUnit.top_organization_unit : organization_unit
  end

  def self.load_users(user,type)
    users = []
    if user.institution
      users = User.where('institution_id = ?', user.institution_id)
    elsif user.facility
      users = User.where('facility_id = ?', user.facility_id)
    elsif user.organization_unit
      users = user.organization_unit.sub_users
    end
    return users
  end

  def to_s
    person
  end

end