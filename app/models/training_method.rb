class TrainingMethod < ApplicationRecord
  has_many :training_titles

  def to_s
    name
  end
end
