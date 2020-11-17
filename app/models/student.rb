class Student < ApplicationRecord
  belongs_to :member
  belongs_to :person

  accepts_nested_attributes_for :person

  has_one_attached :student_id_card

  after_save :correct_record, unless: :no_individual_record

  def correct_record
      unless person.individual.blank?
        person.individual.destroy
      end
  end

  def no_individual_record
    person.individual.blank?
  end

end
