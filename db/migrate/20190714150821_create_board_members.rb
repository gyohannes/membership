class CreateBoardMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :board_members do |t|
      t.references :board_members_term, foreign_key: true
      t.string :title
      t.references :person, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
