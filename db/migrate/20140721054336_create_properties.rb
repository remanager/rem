class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :ref
      t.references :town, index: true
      t.references :user, index: true
      t.references :category, index: true
      t.references :detail, index: true

      t.timestamps
    end
  end
end
