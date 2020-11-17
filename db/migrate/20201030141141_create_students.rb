class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students, id: :uuid do |t|
      t.references :member, type: :uuid, foreign_key: true
      t.references :person, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
