class CpdCourseEnrollment < ApplicationRecord
  belongs_to :cpd_course
  has_many :enrollment_credits

  accepts_nested_attributes_for :enrollment_credits, allow_destroy: true

end
