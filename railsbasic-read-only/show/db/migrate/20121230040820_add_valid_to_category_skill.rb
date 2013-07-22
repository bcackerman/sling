class AddValidToCategorySkill < ActiveRecord::Migration
  def change
    add_column    :categories,  :is_valid,  :boolean, :default => false
    add_column    :skills,      :is_valid,  :boolean, :default => false

    change_column :posts, :success,   :boolean, :default => false
  end
end
