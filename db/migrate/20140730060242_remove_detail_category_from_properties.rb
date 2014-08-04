class RemoveDetailCategoryFromProperties < ActiveRecord::Migration
  def up
    remove_reference :properties, :detail, index: true
    remove_reference :properties, :category, index: true
  end

  def down
    add_reference :properties, :detail, index: true
    add_reference :properties, :category, index: true
  end
end
