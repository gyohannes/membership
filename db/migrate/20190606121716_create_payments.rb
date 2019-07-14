class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :person, foreign_key: true
      t.references :budget_year, foreign_key: true
      t.text :remark
      t.boolean :status

      t.timestamps
    end
  end
end
