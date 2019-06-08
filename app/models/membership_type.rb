class MembershipType < ApplicationRecord
  has_many :people

  def members_by_status(status, year=MpYear.active)
    members = []
    paid = people.joins(:payments).where('mp_year_id = ?', year.try(:id))
    if status == 'Paid'
      members = paid
    else
      members = people - paid
    end
    return members
  end

	def to_s
		name
	end 
end
