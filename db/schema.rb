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

ActiveRecord::Schema.define(version: 20170220123251) do

  create_table "comments", force: :cascade do |t|
    t.string   "description",       limit: 255
    t.integer  "parent_comment_id", limit: 4
    t.integer  "post_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "status",     limit: 255
    t.integer  "owner_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "admin_team", limit: 65535
  end

  create_table "invite_histories", force: :cascade do |t|
    t.string   "invited_by", limit: 255
    t.string   "invited_to", limit: 255
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "invite_histories", ["group_id"], name: "index_invite_histories_on_group_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "person_groups", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "person_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "person_groups", ["group_id"], name: "index_person_groups_on_group_id", using: :btree
  add_index "person_groups", ["person_id"], name: "index_person_groups_on_person_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "group_id",    limit: 4
    t.integer  "person_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id", using: :btree
  add_index "posts", ["person_id"], name: "index_posts_on_person_id", using: :btree

  add_foreign_key "invite_histories", "groups"
end
