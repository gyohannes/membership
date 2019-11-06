class User < ApplicationRecord
  belongs_to :organization_unit, optional: true
  belongs_to :institution, optional: true
  belongs_to :facility, optional: true
  has_one :person
  has_many :sent_requests, :class_name => 'SupportRequest', :foreign_key => "sender"
  has_many :incoming_requests, :class_name => 'SupportRequest', :foreign_key => "receiver"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  accepts_nested_attributes_for :person

  ROLES = [ADMIN='Admin', MEMBER='Member', INSTITUTION='Institution']

  def super_admin?
    organization_unit == OrganizationUnit.top_organization_unit
  end

  def new_members
    organization_unit.sub_people.where(status: nil) rescue nil
  end

  def new_support_requests
    incoming_requests.where(status: nil)
  end

  def has_role(role_name)
    role == role_name and !super_admin?
  end

  def admin?
    !organization_unit.blank?
  end

  def admin
    !organization_unit.blank?
  end

  def parent_org_unit
    !institution.blank? ? OrganizationUnit.top_organization_unit : organization_unit
  end

  def self.load_users(user,type)
    users = []
    if user.super_admin?
      users = User.all
    elsif user.institution
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