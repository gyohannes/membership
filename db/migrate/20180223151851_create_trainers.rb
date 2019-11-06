class CreateTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :trainers,id: :uuid do |t|
      t.references :training, type: :uuid, foreign_key: true
      t.references :person, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
