class ChangeDataFormatInPosts < ActiveRecord::Migration
  def self.up
    change_column :posts, :voice, :string
  end

  def self.down
    change_column :posts, :voice, :binary
  end
end
