class InstitutionType < ApplicationRecord

  has_many :institutions

  validates :name, presence: true

  def to_s
    name
  end
end
