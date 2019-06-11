class Training < ApplicationRecord
  belongs_to :training_title
  belongs_to :institution, optional: true
  belongs_to :budget_year
  has_many :training_funds, dependent: :destroy
  has_many :trainers, dependent: :destroy
  has_many :trainees, dependent: :destroy
  has_many :trainee_distributions, dependent: :destroy
  accepts_nested_attributes_for :training_funds, allow_destroy: true

  TRAINING_STATUSES = [NOT_STARTED='Not Started', CANCELED='Canceled', IN_PROGRESS='In Progress', COMPLETED='Completed']

  validates :training_title_id, :training_type, :start_time, :end_time, :location, presence: true

  scope :upcoming_trainings, -> { where('date(start_time) >= ?',Date.today) }

  scope :trainings_in_progress, -> { where('date(start_time) <= ? and date(end_time) >= ?',Date.today,Date.today) }

  scope :type_trainings, -> (type) { where('training_type = ?', type)}

  scope :all_institution_trainings, -> (ins,from=nil,to=nil){ ins.trainings.where('start_time >= ? and start_time <= ?',from || true, to || Date::Infinity) +
      Training.joins(:training_funds).where('start_time >= ? and start_time <= ? and training_funds.institution_id = ?',from || true, to || Date::Infinity,ins.id) }

  scope :all_org_trainings, -> (org,from=nil,to=nil) { (Training.where('start_time >= ? and start_time <= ? and organization_unit_id in (?)', from || true, to || Date::Infinity, org.sub_units.pluck(:id) << org.id) +
      Training.joins(:trainee_distributions).where('start_time >= ? and start_time <= ? and trainee_distributions.organization_unit_id in (?)', from || true, to || Date::Infinity, org.sub_units.pluck(:id) << org.id)).uniq}

  def training_status
    if status.blank?
      start_time > Date.today ? Training::NOT_STARTED : (start_time <= Date.today and end_time >= Date.today ? Training::IN_PROGRESS : Training::COMPLETED)
    else
      status
    end
  end

  def max_possible_trainees(org_unit)
    if org_unit == OrganizationUnit.top_organization_unit
      return training_title.maximum_number_of_participants
    elsif !org_unit.blank?
      return trainee_distributions.where('organization_unit_id = ?', org_unit.id).pluck(:number_of_trainees).sum
    else
      return 0
    end
  end

  def total_trainees(org_unit)
    if org_unit == OrganizationUnit.top_organization_unit
      return trainees.count
    else
      return trainees.joins(:person).where('organization_unit_id in (?)', org_unit.sub_units.pluck(:id)).size
    end
  end

  def remaining_trainees(org_unit)
    return max_possible_trainees(org_unit) - total_trainees(org_unit)
  end

  def self.load_trainings(user,type=nil,from=nil,to=nil)
    trainings = []
    if user.institution
      if type == 'Pre-Service'
        trainings = Training.type_trainings('Pre-Service').all_institution_trainings(user.institution,from,to)
      elsif type == 'In-Service'
        trainings = Training.type_trainings('In-Service').all_institution_trainings(user.institution)
      elsif type == 'upcoming'
        trainings = Training.upcoming_trainings.all_institution_trainings(user.institution,from,to)
      elsif type == 'progress'
        trainings = Training.trainings_in_progress.all_institution_trainings(user.institution,from,to)
      else
        trainings = Training.all_institution_trainings(user.institution,from,to)
      end
    elsif user.organization_unit
      if type == 'Pre-Service'
        trainings = Training.type_trainings('Pre-Service').all_org_trainings(user.organization_unit,from,to)
      elsif type == 'In-Service'
        trainings = Training.type_trainings('In-Service').all_org_trainings(user.organization_unit)
      elsif type == 'upcoming'
        trainings = Training.upcoming_trainings.all_org_trainings(user.organization_unit,from,to)
      elsif type == 'progress'
        trainings = Training.trainings_in_progress.all_org_trainings(user.organization_unit,from,to)
      else
        trainings = Training.all_org_trainings(user.organization_unit,from,to)
      end
    end
    return trainings.uniq
  end

  def self.search_by_tpt(type, area, title)
    trainings = []
    if !type.blank? and !area.blank? and !title.blank?
      trainings = joins(:training_title).
          where('training_type = ? and program_area_id = ? and training_title_id = ?',type,area,title).uniq
    elsif !type.blank? and !area.blank?
      trainings = joins(:training_title).
          where('training_type = ? and program_area_id = ?',type,area).uniq
    elsif !type.blank? and !title.blank?
      trainings = where('training_type = ? and training_title_id = ?', type,title).uniq
    elsif !area.blank? and !title.blank?
      trainings = joins(:training_title).
          where('program_area_id = ? and training_title_id = ?',area,title).uniq
    elsif !type.blank?
      trainings = where('training_type = ?',type).uniq
    elsif !area.blank?
      trainings = joins(:training_title).where('program_area_id = ?',area).uniq
    elsif !title.blank?
      trainings = where('training_title_id = ?',title).uniq
    end
    return trainings
  end

  def name_and_date
    [to_s, '(',[start_time, end_time].join(' - '),')'].join(' ')
  end

  def to_s
    training_title
  end

end
