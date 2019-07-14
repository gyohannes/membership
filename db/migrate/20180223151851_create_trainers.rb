class CreateTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :trainers do |t|
      t.references :training, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
