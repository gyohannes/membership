class CreateEventApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :event_applicants, id: :uuid do |t|
      t.references :person, type: :uuid, foreign_key: true
      t.references :event, type: :uuid, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
