class BudgetYear < ApplicationRecord
  has_many :trainings
  has_many :payments
  has_many :mp_amount_settings

  def self.active
    where(status: true).last
  end

  def budget_year_status
    status == true ? 'Active' : ''
  end
def expected_payment_amount(user)
    user.organization_unit.sub_people.collect{|x| x.payment_amount(self.id) || 0}.sum
  end

  def payment_amount(member_type)
    mp_amount_settings.where('membership_type_id = ?', member_type).first.try(:amount)
  end

  def paid_members
    payments.joins(:person)
  end

  def budget_year_payments(user)
    payments.joins(:budget_year).where('budget_years.id = ? and person_id in (?)', self.id, user.organization_unit.sub_people.pluck(:id))
  end

  def total_paid_amount(user)
    budget_year_payments(user).joins(:budget_year=>:mp_amount_settings).uniq.collect{|x| x.payment_amount}.sum
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
