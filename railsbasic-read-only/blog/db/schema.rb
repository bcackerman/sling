# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120101194918) do

  create_table "admins", :force => true do |t|
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                   :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true
  add_index "admins", ["username"], :name => "index_admins_on_username", :unique => true

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.integer  "liked"
    t.string   "voice"
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.text     "content"
    t.integer  "liked"
    t.string   "voice"
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "visited_at"
    t.datetime "refreshed_at"
  end

  create_table "gnews", :force => true do |t|
    t.text     "text_entry"
    t.string   "language"
    t.string   "voice"
    t.integer  "voice_played"
    t.string   "video"
    t.integer  "video_played"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "topic_date"
  end

  create_table "posts", :force => true do |t|
    t.text     "text_entry"
    t.string   "language"
    t.integer  "voice_played"
    t.datetime "created_at"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.boolean  "is_topic",     :default => false
    t.string   "voice"
    t.datetime "removed_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "liked"
    t.string   "voice"
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "password_salt",                       :default => "",   :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "avatar"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "gravatar"
    t.boolean  "is_avatar",                           :default => true, :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
