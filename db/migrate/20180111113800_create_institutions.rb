class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :name
      t.references :institution_type, foreign_key: true
      t.string :address
      t.string :url
      t.string :contact_person
      t.string :email
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
