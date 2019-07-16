class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :id_number
      t.date :date_of_birth
      t.string :gender
      t.string :email
      t.string :phone_number
      t.references :organization_unit, foreign_key: true
      t.string :kebelle
      t.string :house_number
      t.references :facility, foreign_key: true
      t.references :user, foreign_key: true
      t.string :job_title
      t.references :profession_category,  foreign_key: true
      t.references :profession,  foreign_key: true
      t.references :membership_type, foreign_key: true

      t.timestamps
    end
  end
end
