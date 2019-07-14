class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.references :organization_unit, foreign_key: true
      t.references :training_title, foreign_key: true
      t.references :budget_year, foreign_key: true
      t.string :training_type
      t.string :category
      t.date :start_time
      t.date :end_time
      t.references :institution, foreign_key: true
      t.string :location
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
