class ChangeUserRoleToString < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "owner"
  end
end
