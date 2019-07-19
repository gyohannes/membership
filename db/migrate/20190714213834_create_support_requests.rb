class CreateSupportRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :support_requests do |t|
      t.integer :sender
      t.integer :receiver
      t.integer :parent_request_id
      t.string :subject
      t.text :message
      t.boolean :status

      t.timestamps
    end
  end
end
