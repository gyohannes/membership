class Person < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :organization_unit
  belongs_to :profession, optional: true
  belongs_to :profession_category, optional: true
  has_many :educations
  has_many :work_experiences
  has_one :trainer_profile
  has_many :trainees
  has_many :trainers
  has_one :individual
  has_one :student

  validates :first_name, :father_name, :grand_father_name, :date_of_birth, :sex, presence: true
  scope :upcoming_birthdays, -> {where('EXTRACT(DAY from date_of_birth) >= ? and EXTRACT(MONTH from date_of_birth) = ? or EXTRACT(MONTH from date_of_birth) = ?',
                                       Date.today.day, Date.today.month, (Date.today + 1.month).month )
                                     .order('EXTRACT(MONTH from date_of_birth), EXTRACT(DAY from date_of_birth)')}
  scope :upcoming_retirements, -> {where('age >= ?', 59.6)}

  has_one_attached :photo

  after_find :set_age

  def self.set_id_number
    association_code = AssociationDetail.first.try(:short_name) || ''
    serial_no = Person.exists? ? (Person.count + 1).to_s : '1'
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
    !payments.where('budget_year_id = ? and status = ?', year, true).blank?
  end

  def payment_amount(budget_year)
    by = BudgetYear.find(budget_year)
    by.mp_amount_settings.where('membership_type_id = ?', self.membership_type_id).first.try(:amount)
  end

  def trained(training)
    !trainees.joins(:training).where('training_title_id = ? and trainings.category = ? and trainees.status in (?) ',
                                     training.training_title_id, training.category, [Trainee::COMPLETED, Trainee::PENDING]).blank?
  end

  def full_name
    [first_name, father_name, grand_father_name].join(' ')
  end

  def set_age
    self[:age] = ((Date.today - date_of_birth).to_f/365).round(1)
  end

  def total_experience
    total = work_experiences.map{|x| x.total_days}.sum
    years = total/365
    total = total%365
    months = total/30
    days = total%30
    return "#{years} Years, #{months} Months and #{days} days"
  end

  def member
    !individual.blank? ? individual.member : student.member
  end

  def membership_type
    !individual.blank? ? individual.member.membership_type : student.member.membership_type rescue nil
  end

  def to_s
    full_name
  end

end
