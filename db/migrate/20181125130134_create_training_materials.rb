class CreateTrainingMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :training_materials do |t|
      t.references :training_title, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
