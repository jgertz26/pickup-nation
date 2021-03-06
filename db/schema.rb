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

ActiveRecord::Schema.define(version: 20151121003609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.integer "meetup_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "attendees", ["meetup_id", "user_id"], name: "index_attendees_on_meetup_id_and_user_id", unique: true, using: :btree

  create_table "court_types", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "courts", force: :cascade do |t|
    t.string   "name",           null: false
    t.float    "latitude",       null: false
    t.float    "longitude",      null: false
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "state",          null: false
    t.string   "zip",            null: false
    t.string   "hours"
    t.integer  "hoop_count",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "court_type_id",  null: false
  end

  add_index "courts", ["street_address", "city", "state", "zip"], name: "index_courts_on_street_address_and_city_and_state_and_zip", unique: true, using: :btree

  create_table "meetups", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "court_id",    null: false
    t.datetime "start_time",  null: false
    t.string   "description"
    t.string   "condition"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "avatar"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
