class CreateBoardMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :board_members, id: :uuid do |t|
      t.references :board_members_term, type: :uuid, foreign_key: true
      t.string :title
      t.references :person, type: :uuid, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
