class AddPermalinkToDetails < ActiveRecord::Migration
  def change
    add_column :details, :permalink, :string, limit: 40
    add_index :details, :permalink, unique: true
  end
end
