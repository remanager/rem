class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :postcode
      t.string :name

      t.timestamps
    end
  end
end
