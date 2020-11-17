class CpdCourse < ApplicationRecord
  belongs_to :cpd_provider

  has_one_attached :attendance_certificate

  def app_status
    status.blank? ? 'Pending' : status
  end

  def to_s
    activity_title
  end

end
