class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :category
      t.references :membership_type, type: :uuid, foreign_key: true
      t.string :id_number
      t.boolean :status

      t.timestamps
    end
  end
end
