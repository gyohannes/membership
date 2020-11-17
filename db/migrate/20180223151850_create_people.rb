class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people,id: :uuid do |t|
      t.string :first_name
      t.string :father_name
      t.string :grand_father_name
      t.string :sex
      t.string :mobile_phone
      t.date :date_of_birth
      t.float :age
      t.string :email
      t.string :nationality
      t.string :country
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :pobox

      t.timestamps
    end
  end
end
