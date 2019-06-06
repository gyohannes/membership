class Payment < ApplicationRecord
  belongs_to :person
  belongs_to :mp_year
end
