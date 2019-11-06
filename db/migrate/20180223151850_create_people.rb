class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people,id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :id_number
      t.date :date_of_birth
      t.string :gender
      t.string :email
      t.string :phone_number
      t.references :membership_type, type: :uuid, foreign_key: true
      t.references :organization_unit, type: :uuid, foreign_key: true
      t.string :kebelle
      t.string :house_number
      t.references :facility, type: :uuid, foreign_key: true
      t.string :job_title
      t.references :profession_category, type: :uuid,  foreign_key: true
      t.references :profession, type: :uuid,  foreign_key: true

      t.timestamps
    end
  end
end
