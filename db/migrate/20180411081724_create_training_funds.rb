class CreateTrainingFunds < ActiveRecord::Migration[5.1]
  def change
    create_table :training_funds, id: :uuid do |t|
      t.references :training, type: :uuid, foreign_key: true
      t.references :institution, type: :uuid, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
