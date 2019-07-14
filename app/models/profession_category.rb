class ProfessionCategory < ApplicationRecord

  has_many :professions

  def to_s
    name
  end
end
