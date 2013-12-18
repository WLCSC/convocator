class AddAttachmentPhotoToOrganizers < ActiveRecord::Migration
  def self.up
    change_table :organizers do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :organizers, :photo
  end
end
