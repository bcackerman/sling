class AddRefreshedAtToFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :refreshed_at, :datetime
  end

  def self.down
    remove_column :friendships, :refreshed_at
  end
end
