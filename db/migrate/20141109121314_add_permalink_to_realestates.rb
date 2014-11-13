class AddPermalinkToRealestates < ActiveRecord::Migration
  def change
    add_column :realestates, :permalink, :string, limit: 40
    add_index :realestates, :permalink, unique: true
  end
end
