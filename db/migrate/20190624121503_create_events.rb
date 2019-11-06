class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :title
      t.date :start_date
      t.date :end_date
      t.integer :maximum_participants
      t.text :event_details
      t.string :location
      t.string :contact_person
      t.string :contact_phone
      t.string :contact_email
      t.boolean :status

      t.timestamps
    end
  end
end
