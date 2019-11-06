class CreateTrainees < ActiveRecord::Migration[5.1]
  def change
    create_table :trainees,id: :uuid do |t|
      t.references :training, type: :uuid, foreign_key: true
      t.references :person, type: :uuid, foreign_key: true
      t.float :pre_training_score
      t.float :post_training_score
      t.string :status
      t.string :training_interest
      t.text :trainer_feedback

      t.timestamps
    end
  end
end
