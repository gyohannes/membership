class Trainee < ApplicationRecord
  belongs_to :training
  belongs_to :person

  STATUSES = [PENDING='Pending', COMPLETED='Completed', NOTCOMPLETED='Not Completed']

  scope :list_by_org_unit, -> (org_unit) { org_unit.blank? ? [] : where('person_id in (?)', OrganizationUnit.find(org_unit).sub_people.pluck(:id)) }
  scope :list_by_program_area, -> (program_area) { joins(:training=>:training_title).where('training_titles.program_area_id = ? ', program_area) }
  scope :list_by_training_title, -> (training_title) { joins(:training=>:training_title).where('training_titles.id = ? ', training_title) }
  scope :list_by_training_category, -> (category) { joins(:training).where('trainings.training_type = ? ', category) }
  scope :list_by_training_type, -> (type) { joins(:training).where('trainings.category = ? ', type) }
  scope :list_by_trainee_status, -> (status) { where('trainees.status = ? ', status) }

  def self.search(org_unit, program_area, training_title, category, type, status)
    trainees = []
    available_filters = {org_unit => list_by_org_unit(org_unit), program_area => list_by_program_area(program_area), training_title => list_by_training_title(training_title),
                         category => list_by_training_category(category), type => list_by_training_type(type), status => list_by_trainee_status(status)}.select{|k,v| !k.blank?}
    counter = 0
    available_filters.each do |k,v|
      trainees = counter == 0 ? v : trainees.merge(v)
      counter += 1
    end
    return trainees.uniq
  end

  def trainee_status

  end

end
