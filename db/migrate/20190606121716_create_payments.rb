class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.references :person, type: :uuid, foreign_key: true
      t.references :budget_year, type: :uuid, foreign_key: true
      t.text :remark
      t.boolean :status

      t.timestamps
    end
  end
end
