class MembershipType < ApplicationRecord
  has_many :people

  def members_by_status(user,status, year=BudgetYear.active)
    members = []
    paid = user.organization_unit.sub_people.joins(:payments).where('budget_year_id = ? and membership_type_id = ?', year.try(:id),self.id)
    if status == 'Paid'
      members = paid
    else
      members = user.organization_unit.sub_people.where('membership_type_id = ?', self.id) - paid
    end
    return members
  end

	def to_s
		name
	end 
end
