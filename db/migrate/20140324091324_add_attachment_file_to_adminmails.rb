class AddAttachmentFileToAdminmails < ActiveRecord::Migration
  def self.up
    change_table :adminmails do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :adminmails, :file
  end
end
