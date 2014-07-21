class CreateRealestates < ActiveRecord::Migration
  def change
    create_table :realestates do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :email
      t.references :user, index: true

      t.timestamps
    end
  end
end
