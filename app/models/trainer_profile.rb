class TrainerProfile < ApplicationRecord
  belongs_to :person
  has_many :trainer_training_titles, dependent: :destroy
  has_many :trainer_languages, dependent: :destroy

  accepts_nested_attributes_for :trainer_training_titles, allow_destroy: true
  accepts_nested_attributes_for :trainer_languages, allow_destroy: true

  validates :trainer_type, presence: true

end
