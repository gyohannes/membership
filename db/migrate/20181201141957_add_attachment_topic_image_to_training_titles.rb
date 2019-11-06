class AddAttachmentTopicImageToTrainingTitles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :training_titles, id: :uuid do |t|
      t.attachment :topic_image
    end
  end

  def self.down
    remove_attachment :training_titles, :topic_image
  end
end
