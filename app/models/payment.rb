class Payment < ApplicationRecord
  belongs_to :people
  belongs_to :mp_year
end
