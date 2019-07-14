class CreateTrainerLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_languages do |t|
      t.references :trainer_profile, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
