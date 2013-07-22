class RemoveRatingFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts,     :rating_count
    remove_column :posts,     :rating_purpose
    remove_column :posts,     :rating_organization
    remove_column :posts,     :rating_body
    remove_column :posts,     :rating_voice
    remove_column :posts,     :rating_humor
    remove_column :posts,     :rating_value
    remove_column :posts,     :rating_power
    remove_column :posts,     :rating_overall
  end
end
