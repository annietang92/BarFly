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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140121203759) do

  create_table "beers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brewed_by"
    t.string   "img_icon"
    t.string   "img_med"
    t.string   "img_lg"
    t.string   "style"
    t.string   "style_type"
    t.string   "abv"
    t.string   "ibu"
    t.string   "is_organic"
    t.integer  "likes"
    t.integer  "total"
    t.integer  "unique"
    t.integer  "monthly"
    t.string   "availability"
    t.string   "serving"
    t.string   "variations"
    t.string   "beer_id"
  end

  create_table "drinks", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "drink_id"
    t.text     "comment"
    t.integer  "likes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_caches", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "uid"
    t.string   "location"
    t.string   "oauth_token"
    t.string   "provider"
    t.string   "picture"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["uid"], name: "index_users_on_uid"

end
