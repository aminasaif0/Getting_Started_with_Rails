class RemoveRolesFromUsers < ActiveRecord::Migration[7.1]
  def change
    drop_table :users
    drop_table :roles_users
  end
end
