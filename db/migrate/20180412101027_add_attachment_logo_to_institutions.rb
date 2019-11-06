class AddAttachmentLogoToInstitutions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :institutions, id: :uuid do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :institutions, :logo
  end
end
