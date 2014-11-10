class AddPermalinkToTowns < ActiveRecord::Migration
  def change
    add_column :towns, :permalink, :string, limit: 40
    add_index :towns, :permalink, unique: true
  end
end
