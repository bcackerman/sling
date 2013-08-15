class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer  "user_id"
      t.integer  "question_id"

      t.text     "content"
      t.integer  "listened"
      t.integer  "liked"
      t.string   "voice"

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end
end
