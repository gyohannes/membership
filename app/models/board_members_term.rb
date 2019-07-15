class BoardMembersTerm < ApplicationRecord
  has_many :board_members

  accepts_nested_attributes_for :board_members, allow_destroy: true

  scope :active, -> {BoardMembersTerm.where(status: true).first}

end
