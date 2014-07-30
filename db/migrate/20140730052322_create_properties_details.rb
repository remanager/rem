class CreatePropertiesDetails < ActiveRecord::Migration
  def change
    create_table :properties_details, id: false do |t|
      t.references :property
      t.references :detail

      t.timestamps
    end

    add_index :properties_details, [:property_id, :detail_id], unique: true
  end
end
