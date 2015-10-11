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

ActiveRecord::Schema.define(version: 20151006080652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "customer_id"
    t.text     "notes",        null: false
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "hourly_rate"
    t.string   "payment_type"
  end

  add_index "appointments", ["customer_id"], name: "index_appointments_on_customer_id", using: :btree

  create_table "blackouts", force: :cascade do |t|
    t.integer  "instructor_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "blackouts", ["instructor_id"], name: "index_blackouts_on_instructor_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "instructors", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "timezone"
  end

  add_index "instructors", ["email"], name: "index_instructors_on_email", unique: true, using: :btree
  add_index "instructors", ["reset_password_token"], name: "index_instructors_on_reset_password_token", unique: true, using: :btree

  create_table "time_suggestions", force: :cascade do |t|
    t.integer  "suggester_id"
    t.string   "suggester_type"
    t.integer  "appointment_id"
    t.datetime "start_at",       null: false
    t.datetime "accepted_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "rejected_at"
  end

  add_index "time_suggestions", ["appointment_id"], name: "index_time_suggestions_on_appointment_id", using: :btree
  add_index "time_suggestions", ["suggester_type", "suggester_id"], name: "index_time_suggestions_on_suggester_type_and_suggester_id", using: :btree

  add_foreign_key "appointments", "customers"
  add_foreign_key "blackouts", "instructors"
  add_foreign_key "time_suggestions", "appointments"
end
