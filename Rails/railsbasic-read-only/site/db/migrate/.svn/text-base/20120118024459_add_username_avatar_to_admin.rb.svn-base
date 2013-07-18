class AddUsernameAvatarToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :username, :string, :default => "", :null => false
    add_column :admins, :avatar, :string
    add_index :admins, :username, :unique => true
  end
end
