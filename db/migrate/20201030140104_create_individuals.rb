class CreateIndividuals < ActiveRecord::Migration[5.2]
  def change
    create_table :individuals, id: :uuid do |t|
      t.references :member, type: :uuid, foreign_key: true
      t.references :person, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
