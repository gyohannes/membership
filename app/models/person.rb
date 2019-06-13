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
  belongs_to :membership_type

  validates :first_name, :middle_name, :last_name, :gender, :date_of_birth, :profession_id,
            :email, :phone_number, :country, :address, presence: true

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  scope :list_by_org_unit, -> (org_unit) { org_unit.blank? ? [] : where('id in (?)', OrganizationUnit.find(org_unit).sub_people.pluck(:id)) }
  scope :list_by_membership_type, -> (member_type) { where('membership_type_id = ?', member_type)}
  scope :list_by_year, -> (year,status) { status == true ? joins(:payments).where('budget_year_id = ?', year) : joins(:payments).where.not('budget_year_id = ?', year) }

  after_create :set_user

  def set_user
    u = User.create(email: email, password: '123456', password_confirmation: '123456')
    self.update(user_id: u.id)
  end

  def self.search(org_unit, membership_type, year, status=nil)
    people = []
    available_filters = {org_unit => list_by_org_unit(org_unit), membership_type => list_by_membership_type(membership_type),
                         year => list_by_year(year,status)}.select{|k,v| !k.blank?}
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
