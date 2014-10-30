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

ActiveRecord::Schema.define(version: 20141030034200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: true do |t|
    t.string   "blogname",       null: false
    t.integer  "user_id",        null: false
    t.text     "description",    null: false
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filepicker_url"
  end

  create_table "follows", force: true do |t|
    t.integer  "source_id",  null: false
    t.integer  "target_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["source_id", "target_id"], name: "index_follows_on_source_id_and_target_id", unique: true, using: :btree

  create_table "likes", force: true do |t|
    t.integer  "blog_id",    null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["blog_id", "post_id"], name: "index_likes_on_blog_id_and_post_id", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body",                             null: false
    t.integer  "blog_id",                          null: false
    t.string   "post_type",                        null: false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reblog",           default: false
    t.integer  "previous_blog_id"
    t.integer  "original_post_id"
  end

  create_table "reblogs", force: true do |t|
    t.integer  "post_id",          null: false
    t.integer  "blog_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "previous_blog_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.string   "session_token",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activated",        default: false
    t.string   "activation_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
