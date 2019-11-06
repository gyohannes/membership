class BoardMembersTerm < ApplicationRecord
  has_many :board_members

  accepts_nested_attributes_for :board_members, allow_destroy: true

  def self.active
    BoardMembersTerm.all.order('board_members_terms.to DESC').first
  end

end
