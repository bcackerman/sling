class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer  "user_id"
      t.integer  "answer_id"

      t.text     "content"
      t.integer  "liked"
      t.string   "voice"

      t.datetime "published_at"
      t.datetime "removed_at"

      t.timestamps
    end
  end
end
