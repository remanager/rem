class AddAttachmentLogoToRealestates < ActiveRecord::Migration
  def self.up
    change_table :realestates do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :realestates, :logo
  end
end
