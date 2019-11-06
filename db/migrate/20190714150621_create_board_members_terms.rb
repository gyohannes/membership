class CreateBoardMembersTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :board_members_terms, id: :uuid do |t|
      t.string :name
      t.date :from
      t.date :to
      t.boolean :status

      t.timestamps
    end
  end
end
