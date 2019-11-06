class AddAttachmentAttachmentToTrainingMaterials < ActiveRecord::Migration[5.1]
  def self.up
    change_table :training_materials, id: :uuid do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :training_materials, :attachment
  end
end
