class MpAmountSetting < ApplicationRecord
  belongs_to :budget_year
  belongs_to :membership_type
end
