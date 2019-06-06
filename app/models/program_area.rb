class ProgramArea < ApplicationRecord
  has_many :training_titles
  validates :name, presence: true

  def trainees_by_type(org_unit, type)
    org_unit.sub_people.joins(:trainees => [:training=>:training_title]).where('trainings.category = ? and training_titles.program_area_id = ? ', type, self.id).count
  end

  def institution_trainees_by_type(institution, type)
    institution.trainees.joins(:training=>:training_title).where('trainings.category = ? and training_titles.program_area_id = ? ', type, self.id).count
  end

  def trainees_by_category(org_unit, category)
    org_unit.sub_people.joins(:trainees => [:training=>:training_title]).where('trainings.training_type = ? and training_titles.program_area_id = ? ', category, self.id).count
  end

  def to_s
    name
  end

end
