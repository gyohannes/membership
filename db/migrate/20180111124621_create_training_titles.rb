class CreateTrainingTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :training_titles,id: :uuid do |t|
      t.string :title
      t.references :program_area, type: :uuid, foreign_key: true
      t.float :duration
      t.string :duration_in
      t.integer :maximum_number_of_participants
      t.references :training_method, type: :uuid, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
