class CreateWorkExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :work_experiences do |t|
      t.references :person, foreign_key: true
      t.string :company
      t.string :job_title
      t.date :from
      t.date :to
      t.text :description

      t.timestamps
    end
  end
end
