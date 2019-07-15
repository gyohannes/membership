class AssociationDetail < ApplicationRecord
  has_attached_file :logo
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
end
