class Institution < ApplicationRecord
  belongs_to :institution_type
  has_many :training_funds
  has_many :trainings
  has_many :users

  validates :name, :institution_type_id, :description, :address, :contact_person, :email, :phone, presence: true

  has_attached_file :logo, styles: { medium: "300x300" },default_url: "missing/missing_logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  def all_trainings(from=nil,to=nil)
    if !from.blank? and !to.blank?
      trainings = self.trainings.where('start_time >= ? and start_time <= ?',from, to) +
          Training.joins(:training_funds).where('start_time >= ? and start_time <= ? and training_funds.institution_id = ?',from, to,self.id)
    else
      trainings = (self.trainings + Training.joins(:training_funds).where('training_funds.institution_id = ?',self.id)).uniq
    end
    return trainings
  end

  def institution_trainees(ou,from,to)
    ou.trainees.where(id: trainees(from, to).pluck(:id))
  end

  def trainees(from=nil,to=nil)
    Trainee.where(training_id: all_trainings(from,to).pluck(:id))
  end

  def to_s
    name
  end

end
