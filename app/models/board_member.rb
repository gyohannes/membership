class BoardMember < ApplicationRecord
  belongs_to :board_members_term
  belongs_to :person

  validates :person_id, uniqueness: {scope: :board_members_term_id}
  validates :person_id, :role, presence: true
end
