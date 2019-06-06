class CreateMpAmountSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :mp_amount_settings do |t|
      t.string :name
      t.references :mp_year, foreign_key: true
      t.references :membership_type, foreign_key: true
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
