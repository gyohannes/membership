class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions, id: :uuid do |t|
      t.references :member, type: :uuid, foreign_key: true
      t.string :name_of_organization
      t.date :establishment_year
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :kebele
      t.string :city
      t.string :telephone_number
      t.string :email
      t.string :website
      t.string :pobox
      t.string :fax
      t.string :contact_name
      t.string :contact_title
      t.string :contact_telephone_number
      t.string :type_of_organization
      t.text :major_objectives

      t.timestamps
    end
  end
end
