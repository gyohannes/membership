class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :member, type: :uuid, foreign_key: true
      t.references :budget_year, type: :uuid, foreign_key: true
      t.integer :amount
      t.string :payment_method
      t.text :remark
      t.boolean :status

      t.timestamps
    end
  end
end
