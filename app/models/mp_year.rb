class MpYear < ApplicationRecord
  has_one :mp_amount_setting
  has_many :payments

  def self.active
    where(status: true).last
  end

  def payment_year_status
    status == true ? 'Active' : ''
  end

  def paid_members
    payments.joins(:person)
  end

  def total_paid_amount
    payments.joins(:mp_year=>:mp_amount_setting).sum(:amount)
  end


  def to_s
    name
  end
end
