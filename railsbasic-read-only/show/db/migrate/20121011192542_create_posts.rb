class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer  "user_id"

      t.string   "video"
      t.string   "poster"

      t.integer  "views"
      t.integer  "likes"

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end
end
