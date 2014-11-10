class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :property
      t.belongs_to :realestate
      t.string :description

      t.timestamps
    end
  end
end
