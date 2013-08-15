class RemoveViewFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :view
  end

  def self.down
    add_column :posts, :view, :integer
  end
end
