class CleanupPosts < ActiveRecord::Migration
  def change

    remove_column :posts, :person_id
    remove_column :posts, :topic_id
    remove_column :posts, :skill_id

    add_column    :posts, :question_id,   :integer

  end
end
