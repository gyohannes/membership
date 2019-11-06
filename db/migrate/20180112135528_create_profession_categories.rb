class CreateProfessionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :profession_categories,id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
