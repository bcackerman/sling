class AddVisitedAtToFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :visited_at, :datetime
  end

  def self.down
    remove_column :friendships, :visited_at
  end
end
