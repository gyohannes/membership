class Person < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :institution, optional: true
  belongs_to :facility, optional: true
  belongs_to :organization_unit, optional: true
  belongs_to :profession, optional: true
  belongs_to :profession_category, optional: true
  has_many :educations
  has_many :work_experiences
  has_one :trainer_profile
  has_many :trainees
  has_many :trainers
  has_many :payments
  belongs_to :membership_type, optional: true

  validates :first_name, :middle_name, :last_name, presence: true

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  scope :list_by_org_unit, -> (org_unit) { org_unit.blank? ? [] : where('people.id in (?)', OrganizationUnit.find(org_unit).sub_people.pluck(:id)) }
  scope :list_by_membership_type, -> (user,member_type) { user.organization_unit.sub_people.where('membership_type_id = ?', member_type)}
  scope :list_by_year, -> (user,year,status) { status == true ? user.organization_unit.sub_people.joins(:payments).where('budget_year_id = ?', year) : user.organization_unit.sub_people - joins(:payments).where('budget_year_id = ?', year) }

  after_create :set_user

  def membership_status
    status.blank? ? 'Pending' :(status==true ? 'Confirmed' : 'Not Accepted')
  end

  def self.set_id_number
    association_code = AssociationDetail.first.try(:short_name) || ''
    serial_no = Person.exists? ? (Person.last.id + 1).to_s : '1'
    while serial_no.length < 7
      serial_no = "0" << serial_no
    end
    return association_code << serial_no
  end

  def set_user
    if user.blank?
    u = User.create(email: email, role: User::MEMBER, password: '123456', password_confirmation: '123456',
      organization_unit_id: organization_unit_id)
    self.update(user_id: u.id)
    end
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
    !payments.where('budget_year_id = ?', year).blank?
  end

  def payment_amount(budget_year)
    by = BudgetYear.find(budget_year)
    by.mp_amount_settings.where('membership_type_id = ?', self.membership_type_id).first.try(:amount)
  end

  def self.search(user,org_unit, membership_type, year, status=nil)
    people = []
    available_filters = {org_unit => list_by_org_unit(org_unit), membership_type => list_by_membership_type(user,membership_type),
                         year => list_by_year(user,year,status)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      people = counter == 0 ? v : people.merge(v)
      counter += 1
    end
    return people.uniq
  end

  def trained(training)
    !trainees.joins(:training).where('training_title_id = ? and trainings.category = ? and trainees.status in (?) ',
                                     training.training_title_id, training.category, [Trainee::COMPLETED, Trainee::PENDING]).blank?
  end

  def full_name
    [first_name, middle_name, last_name].join(' ')
  end

  def to_s
    full_name
  end

end
