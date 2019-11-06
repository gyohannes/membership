class CreateTrainerTrainingTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_training_titles, id: :uuid do |t|
      t.references :trainer_profile, type: :uuid, foreign_key: true
      t.references :training_title, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
