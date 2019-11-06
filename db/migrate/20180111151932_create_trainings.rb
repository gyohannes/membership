class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings,id: :uuid do |t|
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.references :training_title, type: :uuid, foreign_key: true
      t.references :budget_year, type: :uuid, foreign_key: true
      t.string :training_type
      t.string :category
      t.date :start_time
      t.date :end_time
      t.references :institution, type: :uuid, foreign_key: true
      t.string :location
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
