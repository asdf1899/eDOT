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

ActiveRecord::Schema.define(version: 20160810064407) do

  create_table "health_centers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "address"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "phone"
    t.date     "starting_therapy_day"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "health_center_id"
    t.integer  "user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "patient_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "patient_id"
    t.date     "date"
    t.text     "health_status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "address"
    t.integer  "position_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "surname"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "phone"
    t.integer  "health_center_id"
    t.string   "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
