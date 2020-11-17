module ApplicationHelper

  def wicked_blob_path(file)
    ActiveStorage::Blob.service.send(:path_for, file.blob.key)
  end

  def bool_to_str(bool)
    bool == true ? 'Yes' : 'No'
  end
end
