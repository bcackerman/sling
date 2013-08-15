class AddTitleCategoryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :category, :string
    add_column :posts, :content, :text
    add_column :posts, :length, :integer
  end
end
