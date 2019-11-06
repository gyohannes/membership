class CreateSupportRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :support_requests, id: :uuid do |t|
      t.integer :sender
      t.integer :receiver
      t.references :parent_request, type: :uuid
      t.string :subject
      t.text :message
      t.boolean :status

      t.timestamps
    end
  end
end
