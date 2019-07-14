class TrainingTitle < ApplicationRecord
  belongs_to :program_area
  belongs_to :training_method
  has_many :trainer_training_titles
  has_many :trainer_profiles, through: :trainer_training_titles
  has_many :people, through: :trainer_profiles
  has_many :trainings
  has_many :trainees, through: :trainings
  has_many :training_materials


  has_attached_file :topic_image, styles: { medium: "200*200" }, default_url: "missing/missing-topic.jpg"
  validates_attachment_content_type :topic_image, content_type: /\Aimage\/.*\z/


  validates :title, :program_area_id, :duration, :duration_in,
            :maximum_number_of_participants, :training_method, presence: true

  scope :list_by_program_area, -> (area) { where('program_area_id = ?', area) }
  scope :list_by_title, -> (title) { title.blank? ? [] : where("lower(title) LIKE ?", "#{title.downcase}%") }

  def self.search(program_area, training_title)
    training_titles = []
    if !program_area.blank? and !training_title.blank?
      training_titles = (list_by_program_area(program_area).list_by_title(training_title)).uniq
    elsif !program_area.blank?
      training_titles = list_by_program_area(program_area)
    elsif !training_title.blank?
      training_titles = list_by_title(training_title)
    end
    return training_titles
  end

  def trainers
    (trainer_profiles.collect{ |tp| tp.person } + trainees.joins(:training).where('trainings.category = ? and trainees.status = ?', 'TOT',Trainee::COMPLETED).collect{ |tt| tt.person }).uniq
  end

  def to_s
    title
  end

end
