class CreateTrainerProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_profiles do |t|
      t.references :person, foreign_key: true
      t.string :trainer_type
      t.string :primary_job
      t.string :secondary_job

      t.timestamps
    end
  end
end
