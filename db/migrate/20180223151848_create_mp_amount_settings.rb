class CreateMpAmountSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :mp_amount_settings,id: :uuid do |t|
      t.string :name
      t.references :budget_year, type: :uuid, foreign_key: true
      t.references :membership_type, type: :uuid, foreign_key: true
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
