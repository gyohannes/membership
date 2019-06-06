class CreateOrganizationUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_units do |t|
      t.string :name
      t.string :short_name
      t.string :code
      t.references :organization_type, foreign_key: true
      t.integer :parent_organization_unit_id
      t.string :url
      t.string :contact_person
      t.string :contact_phone
      t.string :contact_email
      t.float :latitude
      t.float :longitude
      t.text :description

      t.timestamps
    end
  end
end
