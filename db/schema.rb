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

ActiveRecord::Schema.define(version: 20161125015740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "digest"
  end

  create_table "best_times", force: true do |t|
    t.string   "interaction"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactions", force: true do |t|
    t.integer  "user_id",           null: false
    t.string   "type",              null: false
    t.text     "configuration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "post_at_best_time"
  end

  create_table "link_interactions", force: true do |t|
    t.integer  "interaction_id",      null: false
    t.integer  "link_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "status_description"
    t.datetime "best_scheduled_time"
  end

  create_table "link_tags", force: true do |t|
    t.integer  "link_id",                    null: false
    t.integer  "tag_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",    default: false
  end

  create_table "links", force: true do |t|
    t.integer  "user_id",                            null: false
    t.string   "title",                              null: false
    t.string   "url",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "content"
    t.string   "digest"
    t.integer  "clicks",             default: 0,     null: false
    t.boolean  "possible_duplicate", default: false
    t.integer  "imminent_clicks",    default: 0
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "share_requests", force: true do |t|
    t.integer "link_id",         null: false
    t.string  "twitter_contact"
    t.string  "email_contact"
  end

  create_table "subscribers", id: :uuid, force: true do |t|
    t.string   "email"
    t.string   "digest",          limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "unsubscribed_at"
    t.datetime "last_sent_at"
  end

  add_index "subscribers", ["id"], name: "index_subscribers_on_id", using: :btree

  create_table "tags", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
