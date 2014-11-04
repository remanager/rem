class CreatePropertiesCategories < ActiveRecord::Migration
  def change
    create_table :properties_categories, id: false do |t|
      t.references :property
      t.references :category

      t.timestamps
    end

    add_index :properties_categories, [:property_id, :category_id], unique: true
  end
end
