class TrainerTrainingTitle < ApplicationRecord
  belongs_to :trainer_profile
  belongs_to :training_title

  validates :training_title_id, presence: true

end
