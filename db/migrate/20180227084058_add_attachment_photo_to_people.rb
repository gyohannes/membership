class AddAttachmentPhotoToPeople < ActiveRecord::Migration[5.1]
  def self.up
    change_table :people do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :people, :photo
  end
end
