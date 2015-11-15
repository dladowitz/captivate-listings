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

ActiveRecord::Schema.define(version: 20151115084351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "password_resets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "position"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photos", ["property_id"], name: "index_photos_on_property_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "domain_type"
    t.string   "domain"
    t.hstore   "details"
    t.integer  "user_id"
    t.boolean  "enabled",     default: true, null: false
  end

  add_index "properties", ["details"], name: "index_properties_on_details", using: :gin

  create_table "sites", force: :cascade do |t|
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sites", ["property_id"], name: "index_sites_on_property_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "level"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_id"
  end

  add_foreign_key "photos", "properties"
  add_foreign_key "sites", "properties"
  add_foreign_key "subscriptions", "users"
end
