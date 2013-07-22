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

ActiveRecord::Schema.define(:version => 20120821140721) do

  create_table "drinks", :force => true do |t|
    t.string   "brand"
    t.string   "type"
    t.string   "color"
    t.string   "taste"
    t.string   "country"
    t.string   "website"
    t.string   "logo"
    t.text     "info1"
    t.text     "info2"
    t.text     "info3"
    t.text     "info4"
    t.text     "info5"
    t.string   "photo1"
    t.string   "photo2"
    t.string   "photo3"
    t.string   "photo4"
    t.string   "photo5"
    t.string   "caption1"
    t.string   "caption2"
    t.string   "caption3"
    t.string   "caption4"
    t.string   "caption5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pub_id"
    t.integer  "drink_id"
    t.integer  "price"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pubs", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.string   "website"
    t.string   "event"
    t.string   "special"
    t.string   "logo"
    t.text     "info1"
    t.text     "info2"
    t.text     "info3"
    t.text     "info4"
    t.text     "info5"
    t.string   "photo1"
    t.string   "photo2"
    t.string   "photo3"
    t.string   "photo4"
    t.string   "photo5"
    t.string   "caption1"
    t.string   "caption2"
    t.string   "caption3"
    t.string   "caption4"
    t.string   "caption5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pubs_drinks", :id => false, :force => true do |t|
    t.integer  "pub_id"
    t.integer  "drink_id"
    t.integer  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "app_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
