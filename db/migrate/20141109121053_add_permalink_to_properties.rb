class AddPermalinkToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :permalink, :string, limit: 40
    add_index :properties, [:permalink, :realestate_id], unique: true
  end
end
