class AddStatusNameSurnameAddresssToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer, default: 0
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :address, :string

    add_index :users, [:status, :email]
  end
end
