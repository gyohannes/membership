class AddAttachmentAttachmentToPayment < ActiveRecord::Migration[5.1]
  def self.up
    change_table :payments, id: :uuid do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :payments, :attachment
  end
end
