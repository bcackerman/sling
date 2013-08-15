class AddEditControlToGnews < ActiveRecord::Migration
  def self.up
    add_column :gnews, :published_at, :datetime
    add_column :gnews, :removed_at, :datetime
  end

  def self.down
    remove_column :gnews, :published_at
    remove_column :gnews, :removed_at
  end
end
