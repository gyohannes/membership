class CreateTrainingFunds < ActiveRecord::Migration[5.1]
  def change
    create_table :training_funds do |t|
      t.references :training, foreign_key: true
      t.references :institution, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
