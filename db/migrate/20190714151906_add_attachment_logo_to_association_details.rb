class AddAttachmentLogoToAssociationDetails < ActiveRecord::Migration[5.1]
  def self.up
    change_table :association_details, id: :uuid do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :association_details, :logo
  end
end
