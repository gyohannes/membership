class CreateTrainingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :training_methods,id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
