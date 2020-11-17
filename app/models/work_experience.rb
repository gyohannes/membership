class WorkExperience < ApplicationRecord
  belongs_to :person

  validates :company, :job_title, :from, :to, presence: true


  def total_days
    (to - from).to_i
  end

end
