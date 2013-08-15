class FixSyntaxErrorInGnews < ActiveRecord::Migration
  def self.up
    remove_column :gnews, :topic_date
    add_column :gnews, :topic_date, :datetime
  end

  def self.down
    
  end
end
