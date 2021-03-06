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

ActiveRecord::Schema.define(version: 20140127233236) do

  create_table "beer_like_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "beer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beer_like_relationships", ["beer_id"], name: "index_beer_like_relationships_on_beer_id"
  add_index "beer_like_relationships", ["user_id", "beer_id"], name: "index_beer_like_relationships_on_user_id_and_beer_id", unique: true
  add_index "beer_like_relationships", ["user_id"], name: "index_beer_like_relationships_on_user_id"

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

  create_table "cocktail_like_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "cocktail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cocktail_like_relationships", ["cocktail_id"], name: "index_cocktail_like_relationships_on_cocktail_id"
  add_index "cocktail_like_relationships", ["user_id", "cocktail_id"], name: "index_cocktail_like_relationships_on_user_id_and_cocktail_id", unique: true
  add_index "cocktail_like_relationships", ["user_id"], name: "index_cocktail_like_relationships_on_user_id"

  create_table "cocktails", force: true do |t|
    t.string   "name"
    t.string   "primary"
    t.string   "iba"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total"
    t.integer  "likes"
    t.string   "alcohols"
    t.string   "served"
    t.string   "glass"
    t.string   "ingredients"
    t.text     "instructions"
    t.text     "description"
    t.string   "image"
  end

  create_table "drink_venue_relationships", force: true do |t|
    t.integer  "drink_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drink_venue_relationships", ["drink_id", "venue_id"], name: "index_drink_venue_relationships_on_drink_id_and_venue_id", unique: true
  add_index "drink_venue_relationships", ["drink_id"], name: "index_drink_venue_relationships_on_drink_id"
  add_index "drink_venue_relationships", ["venue_id"], name: "index_drink_venue_relationships_on_venue_id"

  create_table "drinks", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "drink_id"
    t.text     "comment"
    t.integer  "likes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
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

  create_table "memorabilia", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

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
    t.string   "recommendations"
    t.string   "new"
    t.string   "feed_preference"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["uid"], name: "index_users_on_uid"

  create_table "venue_like_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_like_relationships", ["user_id", "venue_id"], name: "index_venue_like_relationships_on_user_id_and_venue_id", unique: true
  add_index "venue_like_relationships", ["user_id"], name: "index_venue_like_relationships_on_user_id"
  add_index "venue_like_relationships", ["venue_id"], name: "index_venue_like_relationships_on_venue_id"

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.text     "description"
    t.string   "url"
    t.string   "hours"
    t.string   "picture"
    t.integer  "likes"
    t.integer  "checkins"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "foursquare_id"
  end

end
