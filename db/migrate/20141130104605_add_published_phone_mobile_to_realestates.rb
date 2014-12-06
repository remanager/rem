class AddPublishedPhoneMobileToRealestates < ActiveRecord::Migration
  def change
    add_column :realestates, :published, :boolean, default: false
    add_column :realestates, :phone, :string, limit: 15
    add_column :realestates, :mobile, :string, limit: 15
  end
end
