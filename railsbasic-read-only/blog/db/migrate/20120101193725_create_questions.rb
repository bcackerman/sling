class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer  "user_id"

      t.text     "content"
      t.integer  "liked"
      t.string   "voice"

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
