class CreateAssociationDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :association_details, id: :uuid do |t|
      t.string :name
      t.string :short_name
      t.string :contact_phone
      t.string :contact_email
      t.text :address
      t.text :about_association

      t.timestamps
    end
  end
end
