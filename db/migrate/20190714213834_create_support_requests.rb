class CreateSupportRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :support_requests do |t|
      t.references :user, foreign_key: true
      t.references :organization_unit, foreign_key: true
      t.string :subject
      t.text :message
      t.boolean :status

      t.timestamps
    end
  end
end
