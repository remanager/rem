class AddDescriptionToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :description, :string, limit: 2000
  end
end
