class AddIdsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :person_id, :integer
    add_column :posts, :topic_id, :integer
  end
end
