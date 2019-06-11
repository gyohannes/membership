class BudgetYear < ApplicationRecord
  has_many :trainings
  has_many :payments

  def self.active
    where(status: true).last
  end

  def budget_year_status
    status == true ? 'Active' : ''
  end

  def paid_members
    payments.joins(:person)
  end

  def total_paid_amount
    payments.joins(:budget_year=>:mp_amount_setting).sum(:amount)
  end

  def trainees_by_year(orga_unit, type)
    orga_unit.sub_people.joins(:trainees => :training).where('trainings.budget_year_id =  ?  and trainings.category = ?',
                                                                                self.id, type,).count
  end

  def institution_trainees_by_year(institution, type)
    institution.trainees.joins(:training).where('trainings.budget_year_id =  ?  and trainings.category = ?',
                                                             self.id, type,).count
  end

  def to_s
    name
  end

end
