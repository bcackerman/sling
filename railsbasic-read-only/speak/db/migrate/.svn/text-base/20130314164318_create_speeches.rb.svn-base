class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|

      t.integer  "user_id"
      t.string   "video_url"
      t.string   "poster_url"
      t.string   "avatar_url"
      t.string   "speaker"
      t.datetime "delivered_by"

      t.integer  "objective"
      t.string   "title",        :default => ""
      t.text     "content",      :default => ""
      t.integer  "length",       :default => 0

      t.integer  "views",        :default => 0
      t.integer  "likes",        :default => 0

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end
end
