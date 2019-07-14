class CreateBudgetYears < ActiveRecord::Migration[5.1]
  def change
    create_table :budget_years do |t|
      t.string :name
      t.date :from
      t.date :to
      t.boolean :status

      t.timestamps
    end
  end
end
