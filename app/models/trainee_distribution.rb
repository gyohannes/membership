class TraineeDistribution < ApplicationRecord
  belongs_to :training
  belongs_to :organization_unit

  validates :training_id, :organization_unit_id, :number_of_trainees, presence: true
end
