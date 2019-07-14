class TrainingFund < ApplicationRecord
  belongs_to :training
  belongs_to :institution

  validates :training_id, :institution_id, :amount, presence: true

  CURRENCIES = [BIRR = 'Birr', USD = 'USD']

  def to_s
    [training, institution].join('-')
  end
end
