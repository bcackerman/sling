class AddFriendlyIdSlugs < ActiveRecord::Migration
  def change
    add_column :posts,      :slug, :string
    add_column :questions,  :slug, :string
    add_column :speeches,   :slug, :string

    add_index  :posts,      :slug
    add_index  :questions,  :slug
    add_index  :speeches,   :slug
  end
end
