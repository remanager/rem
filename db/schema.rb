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

ActiveRecord::Schema.define(version: 20141104151643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",  limit: 40
  end

  add_index "categories", ["permalink"], name: "index_categories_on_permalink", unique: true, using: :btree

  create_table "details", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "ref"
    t.integer  "town_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "realestate_id"
  end

  add_index "properties", ["realestate_id"], name: "index_properties_on_realestate_id", using: :btree
  add_index "properties", ["town_id"], name: "index_properties_on_town_id", using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "properties_categories", id: false, force: true do |t|
    t.integer  "property_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties_categories", ["property_id", "category_id"], name: "index_properties_categories_on_property_id_and_category_id", unique: true, using: :btree

  create_table "properties_details", id: false, force: true do |t|
    t.integer  "property_id"
    t.integer  "detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties_details", ["property_id", "detail_id"], name: "index_properties_details_on_property_id_and_detail_id", unique: true, using: :btree

  create_table "realestates", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "realestates", ["user_id"], name: "index_realestates_on_user_id", using: :btree

  create_table "towns", force: true do |t|
    t.string   "postcode"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.integer  "role"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
