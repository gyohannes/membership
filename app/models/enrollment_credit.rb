class EnrollmentCredit < ApplicationRecord
  belongs_to :cpd_course_enrollment
  belongs_to :person
end
