class CreateEventApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :event_applicants do |t|
      t.references :person, foreign_key: true
      t.references :event, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
