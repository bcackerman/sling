class RemoveOutdatedLikes < ActiveRecord::Migration
  def change
    remove_column :posts,     :likes
    remove_column :questions, :likes
    remove_column :speeches,  :likes
    remove_column :quotes,    :likes
  end
end
