# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130514221747) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.text     "content",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "objectives", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_valid",   :default => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "video"
    t.integer  "views",        :default => 0
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "title",        :default => ""
    t.text     "content",      :default => ""
    t.integer  "length",       :default => 0
    t.boolean  "success",      :default => false
    t.string   "privacy",      :default => "Public"
    t.integer  "question_id"
    t.string   "category"
    t.integer  "objective_id"
    t.integer  "speech_id"
    t.string   "slug"
    t.string   "video_cloud"
    t.string   "poster_cloud"
    t.boolean  "processed"
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug"

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",        :default => ""
    t.text     "content",      :default => ""
    t.integer  "views",        :default => 0
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "slug"
    t.integer  "subject_id"
  end

  add_index "questions", ["slug"], :name => "index_questions_on_slug"

  create_table "quotes", :force => true do |t|
    t.integer  "user_id"
    t.string   "author"
    t.string   "title",        :default => ""
    t.text     "content",      :default => ""
    t.integer  "views",        :default => 0
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "link_id"
    t.integer  "overall",      :default => 0
    t.integer  "purpose",      :default => 0
    t.integer  "organization", :default => 0
    t.integer  "body",         :default => 0
    t.integer  "voice",        :default => 0
    t.integer  "humor",        :default => 0
    t.integer  "value",        :default => 0
    t.integer  "power",        :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "speeches", :force => true do |t|
    t.integer  "user_id"
    t.string   "video_url"
    t.string   "poster_url"
    t.string   "avatar_url"
    t.string   "speaker"
    t.string   "delivered_by", :default => ""
    t.string   "objective",    :default => ""
    t.string   "title",        :default => ""
    t.text     "content",      :default => ""
    t.integer  "length",       :default => 0
    t.integer  "views",        :default => 0
    t.datetime "published_at"
    t.datetime "removed_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "slug"
  end

  add_index "speeches", ["slug"], :name => "index_speeches_on_slug"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.boolean  "is_valid",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",                  :null => false
    t.string   "encrypted_password",     :default => "",                  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "name"
    t.string   "avatar"
    t.string   "memo",                   :default => "Click to add Memo"
    t.string   "roles",                  :default => "--- []"
    t.string   "avatar_cloud"
    t.string   "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

end
