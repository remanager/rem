class AddRealestateToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :realestate, index: true
  end
end
