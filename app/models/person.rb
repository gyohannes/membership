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


  def trained(training)
    !trainees.joins(:training).where('training_title_id = ? and trainings.category = ? and trainees.status in (?) ',
                                     training.training_title_id, training.category, [Trainee::COMPLETED, Trainee::PENDING]).blank?
  end

  def full_name
    [title, first_name, middle_name, last_name].join(' ')
  end

  def to_s
    full_name
  end

end
