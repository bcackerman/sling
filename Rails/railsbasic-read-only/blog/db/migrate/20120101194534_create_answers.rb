class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer  "user_id"
      t.integer  "question_id"

      t.text     "content"
      t.integer  "liked"
      t.string   "voice"

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
