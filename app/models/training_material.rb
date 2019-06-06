class TrainingMaterial < ApplicationRecord
  belongs_to :training_title

  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: /\A*\/.*\z/
end
