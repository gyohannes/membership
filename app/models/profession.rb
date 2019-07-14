class Profession < ApplicationRecord
  belongs_to :profession_category

  def to_s
    name
  end
end
