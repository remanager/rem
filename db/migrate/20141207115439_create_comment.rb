class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :realestate
      t.references :property
      t.string :text, limit: 2000
      t.string :email
      t.boolean :published, default: false

      t.timestamps
    end

    add_index :comments, [:realestate_id, :property_id, :published]
  end
end
