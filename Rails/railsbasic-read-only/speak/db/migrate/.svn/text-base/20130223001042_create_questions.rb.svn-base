class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer  "user_id"

      t.string   "title",        :default => ""
      t.text     "content",      :default => ""

      t.integer  "views",        :default => 0
      t.integer  "likes",        :default => 0

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end
end
