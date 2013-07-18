class AddObjectiveSpeechIdToPosts < ActiveRecord::Migration
  def change
    remove_column    :posts, :category_id
    remove_column    :posts, :goal_id

    add_column       :posts, :category,       :string
    add_column       :posts, :objective_id,   :integer
    add_column       :posts, :speech_id,      :integer

  end
end
