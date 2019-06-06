class CreateTrainerTrainingTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_training_titles do |t|
      t.references :trainer_profile, foreign_key: true
      t.references :training_title, foreign_key: true

      t.timestamps
    end
  end
end
