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

ActiveRecord::Schema.define(version: 20140531123242) do

  create_table "artobjects", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.integer  "minday"
    t.integer  "minmonth"
    t.integer  "minyear"
    t.integer  "maxday"
    t.integer  "maxmonth"
    t.integer  "maxyear"
    t.boolean  "approximatedate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "artobject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["artobject_id"], name: "index_favorites_on_artobject_id"
  add_index "favorites", ["user_id", "artobject_id"], name: "index_favorites_on_user_id_and_artobject_id", unique: true
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
