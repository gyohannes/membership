class Payment < ApplicationRecord
  belongs_to :person
  belongs_to :budget_year

  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: ['application/pdf',/\Aimage\/.*\z/]
  validates :payment_method, presence: true
  validates :person_id, uniqueness: { scope: :budget_year_id, message: 'has already paid'}

  scope :list_by_org_unit, -> (org_unit) { org_unit.blank? ? [] : Person.where('people.id in (?)', OrganizationUnit.find(org_unit).sub_people.pluck(:id)) }
  scope :list_by_membership_type, -> (type) { joins(:person).where('membership_type_id = ?', type)}
  scope :list_by_year, -> (year) { where('budget_year_id = ?', year)}

  scope :list_by_program_area, -> (program_area) { joins(:training=>:training_title).where('training_titles.program_area_id = ? ', program_area) }
  scope :list_by_training_title, -> (training_title) { joins(:training=>:training_title).where('training_titles.id = ? ', training_title) }
  scope :list_by_training_category, -> (category) { joins(:training).where('trainings.training_type = ? ', category) }
  scope :list_by_training_type, -> (type) { joins(:training).where('trainings.category = ? ', type) }
  scope :list_by_trainee_status, -> (status) { where('trainees.status = ? ', status) }

  def payment_status
    status == nil ? 'Pending Confirmation' : 'Confirmed'
  end

  def payment_amount
    budget_year.mp_amount_settings.where('membership_type_id = ?', self.person.membership_type_id).first.try(:amount)
  end
end