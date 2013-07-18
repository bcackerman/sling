class RenameColNameInPosts < ActiveRecord::Migration
  def self.up
    rename_column :posts, :entry, :text_entry
    rename_column :posts, :voice, :voice_url
    rename_column :posts, :lang, :language
    rename_column :posts, :like, :voice_played
  end

  def self.down
    rename_column :posts, :text_entry, :entry
    rename_column :posts, :voice_url, :voice
    rename_column :posts, :language, :lang
    rename_column :posts, :voice_played, :like
  end
end
