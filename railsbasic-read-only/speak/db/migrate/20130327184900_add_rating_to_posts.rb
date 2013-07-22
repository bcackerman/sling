class AddRatingToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rating_count,         :integer, :default => 0
    add_column :posts, :rating_purpose,       :integer, :default => 0
    add_column :posts, :rating_organization,  :integer, :default => 0
    add_column :posts, :rating_body,          :integer, :default => 0
    add_column :posts, :rating_voice,         :integer, :default => 0
    add_column :posts, :rating_humor,         :integer, :default => 0
    add_column :posts, :rating_value,         :integer, :default => 0
    add_column :posts, :rating_power,         :integer, :default => 0
    add_column :posts, :rating_overall,       :integer, :default => 0
  end
end
