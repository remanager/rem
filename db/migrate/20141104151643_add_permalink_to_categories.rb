class AddPermalinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :permalink, :string, limit: 40
    add_index :categories, [:permalink], unique: true
  end
end
