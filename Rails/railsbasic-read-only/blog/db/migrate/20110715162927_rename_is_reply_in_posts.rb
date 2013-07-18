class RenameIsReplyInPosts < ActiveRecord::Migration
  def self.up
    rename_column :posts, :is_reply, :is_topic
  end

  def self.down
    rename_column :posts, :is_topic, :is_reply
  end
end
