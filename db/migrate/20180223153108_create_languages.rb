class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages,id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
