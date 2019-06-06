class CreateProfessions < ActiveRecord::Migration[5.1]
  def change
    create_table :professions do |t|
      t.references :profession_category, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
