class CreateGnews < ActiveRecord::Migration
  def self.up
    create_table :gnews do |t|
      t.text     "text_entry"
      t.string   "language"
      t.string   "voice"
      t.integer  "voice_played"
      t.string   "video"
      t.integer  "video_played"
      t.integer  "topic_id"
      t.datetime "topic_date"

      t.timestamps
    end
  end

  def self.down
    drop_table :gnews
  end
end
