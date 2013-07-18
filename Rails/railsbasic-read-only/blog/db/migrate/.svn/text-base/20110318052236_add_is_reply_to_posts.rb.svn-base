class AddIsReplyToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_reply, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :is_reply
  end
end
