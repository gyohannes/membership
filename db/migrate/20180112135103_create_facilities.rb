class CreateFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.references :facility_type, foreign_key: true
      t.string :code
      t.references :organization_unit, foreign_key: true
      t.string :ownership
      t.string :contact_person
      t.string :contact_phone
      t.string :contact_email
      t.string :url
      t.integer :latitude
      t.integer :longitude
      t.text :description

      t.timestamps
    end
  end
end
