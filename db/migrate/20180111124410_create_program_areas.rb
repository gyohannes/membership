class CreateProgramAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :program_areas,id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
