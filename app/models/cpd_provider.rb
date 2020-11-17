class CpdProvider < ApplicationRecord
  belongs_to :user
  belongs_to :organization_unit

  has_one_attached :cpd_director

  after_find :remove_blank

  def remove_blank
    self[:telephone_fax_email] = telephone_fax_email.reject{|x| x.blank?}
    self[:computer_printer_lcd_photo_copy] = computer_printer_lcd_photo_copy.reject{|x| x.blank?}
  end

  def app_status
    status.blank? ? 'Pending' : status
  end

  def to_s
    name_of_organization
  end

end
