class Individual < ApplicationRecord
  belongs_to :member
  belongs_to :person

  accepts_nested_attributes_for :person
  accepts_nested_attributes_for :member

  after_save :correct_record, unless: :no_student_record

  def correct_record
    unless person.student.blank?
      person.student.destroy
    end
  end

  def no_student_record
    person.student.blank?
  end

end
