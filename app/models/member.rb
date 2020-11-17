class Member < ApplicationRecord
  belongs_to :user
  belongs_to :membership_type, optional: true
  has_one :individual
  has_one :student
  has_one :institution
  has_many :payments

  before_save :set_membership_type

  scope :list_by_org_unit, -> (org_unit) { org_unit.blank? ? [] : where('members.id in (?)', OrganizationUnit.find(org_unit).sub_members.pluck(:id)) }
  scope :list_by_membership_type, -> (user,member_type) { user.organization_unit.sub_members.where('membership_type_id = ?', member_type)}
  scope :list_by_year, -> (user,year,status) { status == true ? user.organization_unit.sub_members.joins(:payments).where('budget_year_id = ?', year)
                                                   : user.organization_unit.sub_members - joins(:payments).where('budget_year_id = ?', year) if !year.blank? or !status.blank? }

  def set_membership_type
    if category == Constants::STUDENT
      self[:membership_type_id] = MembershipType.type_student.try(:id)
    elsif category == Constants::INSTITUTION
      self[:membership_type_id] = MembershipType.type_institution.try(:id)
    end
  end

  def self.search(user,org_unit, membership_type, year, status=nil)
    members = []
    available_filters = {org_unit => list_by_org_unit(org_unit), membership_type => list_by_membership_type(user,membership_type),
                         year => list_by_year(user,year,status)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      members = counter == 0 ? v : members.merge(v)
      counter += 1
    end
    return members.uniq
  end

  def unpaid_fees
    @unpaid_fees = []
    BudgetYear.all.each do |by|
      unless paid(by.id)
        @unpaid_fees << by
      end
    end
    return @unpaid_fees
  end

  def paid(year)
    !payments.where('budget_year_id = ? and status = ?', year, true).blank?
  end

  def payment_amount(budget_year)
    by = BudgetYear.find(budget_year)
    by.mp_amount_settings.where('membership_type_id = ?', self.membership_type_id).first.try(:amount)
  end

  def membership_status
    status.blank? ? 'Pending' :(status==true ? 'Confirmed' : 'Not Accepted')
  end

  def self.set_id_number
    association_code = AssociationDetail.first.try(:short_name) || ''
    serial_no = Person.exists? ? (Person.count + 1).to_s : '1'
    while serial_no.length < 7
      serial_no = "0" << serial_no
    end
    return association_code << serial_no
  end

  def org_unit
    category == Constants::INDIVIDUAL ? individual.person.organization_unit :
        (category == Constants::STUDENT ? student.person.organization_unit : institution.organization_unit)
  end

  def to_s
    category == Constants::INDIVIDUAL ? individual.person :
        (category == Constants::STUDENT ? student.person : institution.name_of_organization)
  end

end
