class AddIsAvatarToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_avatar, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :users, :is_avatar
  end
end
