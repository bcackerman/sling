class RemoveVoiceUrlFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :voice_url
  end

  def self.down
    add_column :posts, :voice_url, :string
  end
end
