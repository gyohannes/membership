class CreateTrainerProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :trainer_profiles,id: :uuid do |t|
      t.references :person, type: :uuid, foreign_key: true
      t.string :trainer_type
      t.string :primary_job
      t.string :secondary_job

      t.timestamps
    end
  end
end
