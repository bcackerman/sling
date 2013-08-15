class RevisePosts < ActiveRecord::Migration
  def change
    add_column    :posts, :success,   :boolean, :default => 0
    add_column    :posts, :privacy,   :string,  :default => 'Public'
    add_column    :posts, :skill,     :string,  :default => "", :null => false

    change_column :posts, :title,     :string,  :default => ""
    change_column :posts, :content,   :text,    :default => ""
    change_column :posts, :views,     :integer, :default => 0
    change_column :posts, :likes,     :integer, :default => 0
    change_column :posts, :length,    :integer, :default => 0
    change_column :posts, :category,  :string,  :default => "", :null => false

    remove_column :posts, :poster
  end
end
