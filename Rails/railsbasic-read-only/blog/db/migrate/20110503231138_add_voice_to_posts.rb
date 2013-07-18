class AddVoiceToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :voice, :string
  end

  def self.down
    remove_column :posts, :voice
  end
end
