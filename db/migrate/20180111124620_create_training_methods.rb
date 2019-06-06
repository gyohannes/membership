class CreateTrainingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :training_methods do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
