class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :name

      t.timestamps
    end
  end
end
