class AddPriceNroomsSizePublishedToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :price_sale, :integer
    add_column :properties, :price_rent, :integer
    add_column :properties, :nrooms, :integer, default: 1
    add_column :properties, :size, :integer
    add_column :properties, :published, :boolean, default: false

    add_index :properties, [:published, :nrooms, :size]
  end
end
