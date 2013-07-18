class ChangeCategorySkillInPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :category
    remove_column :posts, :skill

    add_column    :posts, :category_id,   :integer
    add_column    :posts, :skill_id,      :integer
  end
end
