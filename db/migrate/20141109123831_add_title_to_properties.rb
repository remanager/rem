class AddTitleToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :title, :string, limit: 100
  end
end
