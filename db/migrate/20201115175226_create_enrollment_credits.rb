class CreateEnrollmentCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollment_credits, id: :uuid do |t|
      t.references :cpd_course_enrollment, type: :uuid, foreign_key: true
      t.references :person, type: :uuid, foreign_key: true
      t.float :ceu

      t.timestamps
    end
  end
end
