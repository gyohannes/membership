class CreateAssociationDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :association_details do |t|
      t.string :name
      t.string :short_name
      t.string :contact_phone
      t.string :contact_email
      t.text :address

      t.timestamps
    end
  end
end
