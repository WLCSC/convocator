class AddAttachmentPhotoToPresenters < ActiveRecord::Migration
  def self.up
    change_table :presenters do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :presenters, :photo
  end
end
