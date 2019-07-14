class TrainerLanguage < ApplicationRecord
  belongs_to :trainer_profile
  belongs_to :language

  validates :language_id, presence: true

end
