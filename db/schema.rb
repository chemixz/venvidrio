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

ActiveRecord::Schema.define(version: 20160405212312) do

  create_table "areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "ubication",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "engines", force: :cascade do |t|
    t.string   "serial",       limit: 255
    t.string   "code",         limit: 255
    t.string   "brand",        limit: 255
    t.string   "model",        limit: 255
    t.float    "hp",           limit: 24
    t.float    "kw",           limit: 24
    t.string   "frame",        limit: 255
    t.integer  "rpm",          limit: 4
    t.float    "hertz",        limit: 24
    t.string   "amperes",      limit: 255
    t.float    "sf",           limit: 24
    t.string   "back_r",       limit: 255
    t.string   "front_r",      limit: 255
    t.string   "mf",           limit: 255
    t.string   "volts",        limit: 255
    t.text     "part_c",       limit: 65535
    t.date     "install_date"
    t.integer  "system_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "engines", ["system_id"], name: "index_engines_on_system_id", using: :btree

  create_table "histories", force: :cascade do |t|
    t.date     "date"
    t.text     "description",  limit: 65535
    t.string   "unmounted_to", limit: 255
    t.string   "installed_to", limit: 255
    t.string   "install_by",   limit: 255
    t.text     "notes",        limit: 65535
    t.integer  "engine_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "histories", ["engine_id"], name: "index_histories_on_engine_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.text     "before_you",  limit: 65535
    t.text     "after_you",   limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id", using: :btree

  create_table "systems", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "ubication",  limit: 65535
    t.integer  "area_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "systems", ["area_id"], name: "index_systems_on_area_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "full_name",              limit: 255,              null: false
    t.string   "full_last_name",         limit: 255,              null: false
    t.integer  "credential",             limit: 4,                null: false
    t.integer  "role",                   limit: 4,   default: 1
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "engines", "systems"
  add_foreign_key "histories", "engines"
  add_foreign_key "logs", "users"
  add_foreign_key "systems", "areas"
end
