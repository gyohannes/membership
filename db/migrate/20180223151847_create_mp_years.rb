class CreateMpYears < ActiveRecord::Migration[5.1]
  def change
    create_table :mp_years do |t|
      t.string :name
      t.date :from
      t.date :to
      t.boolean :status
      t.text :description

      t.timestamps
    end
  end
end
