class CreateCpdCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :cpd_courses, id: :uuid do |t|
      t.references :cpd_provider, type: :uuid, foreign_key: true
      t.string :activity_title
      t.string :method_of_delivery
      t.string :date_of_activity
      t.string :target_audience
      t.string :venue_of_activity
      t.integer :registration_fee_involved_for_participants
      t.float :duration_of_the_learning_activity
      t.integer :suggested_ceu
      t.string :ethics
      t.string :mechanism_for_monitoring
      t.string :mechanism_for_monitoring_attendance
      t.string :status

      t.timestamps
    end
  end
end
