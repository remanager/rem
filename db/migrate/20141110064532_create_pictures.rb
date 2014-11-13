class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :property
      t.string :description
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
