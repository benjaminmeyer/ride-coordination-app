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

ActiveRecord::Schema.define(version: 20150407051030) do

  create_table "events", force: true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.string   "address"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "deleted",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["organization_id"], name: "index_events_on_organization_id", using: :btree

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "role",            limit: 25
    t.boolean  "deleted",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_id", "organization_id"], name: "index_members_on_user_id_and_organization_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name",       limit: 60
    t.string   "semester",   limit: 25
    t.integer  "year"
    t.boolean  "deleted",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: true do |t|
    t.integer  "user_id"
    t.integer  "ride_id"
    t.string   "role",       limit: 25
    t.boolean  "deleted",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passengers", ["user_id", "ride_id"], name: "index_passengers_on_user_id_and_ride_id", using: :btree

  create_table "rides", force: true do |t|
    t.integer  "event_id"
    t.integer  "num_passengers"
    t.text     "notes"
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rides", ["event_id"], name: "index_rides_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 25
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "deleted",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
