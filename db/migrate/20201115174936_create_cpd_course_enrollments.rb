class CreateCpdCourseEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :cpd_course_enrollments, id: :uuid do |t|
      t.references :cpd_course, type: :uuid, foreign_key: true
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
