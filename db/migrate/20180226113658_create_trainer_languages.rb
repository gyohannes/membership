class CreateTrainerLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_languages, id: :uuid do |t|
      t.references :trainer_profile, type: :uuid, foreign_key: true
      t.references :language, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
