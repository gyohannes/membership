class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations, id: :uuid do |t|
      t.references :person, type: :uuid, foreign_key: true
      t.string :institution_name
      t.string :study_field
      t.string :qualification
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
