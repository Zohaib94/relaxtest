class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, limit: 30, default: User::ROLES[:free]
  end
end
