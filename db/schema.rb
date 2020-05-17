# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_17_164039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patients", force: :cascade do |t|
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "name"
    t.integer "age"
    t.integer "weight"
    t.boolean "fever", default: false
    t.boolean "tired", default: false
    t.boolean "headache", default: false
    t.boolean "cough", default: false
    t.boolean "short_breath", default: false
    t.boolean "diarrhea", default: false
    t.boolean "hyposmia", default: false
    t.boolean "hypogeusia", default: false
    t.bigint "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state"
    t.string "description"
    t.boolean "sore_throat", default: false
    t.boolean "red_fingers", default: false
    t.index ["phone_id"], name: "index_patients_on_phone_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number", null: false
    t.string "sms_code"
    t.boolean "is_verified", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.index ["number"], name: "index_phones_on_number", unique: true
    t.index ["token"], name: "index_phones_on_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "token", null: false
    t.string "password_reset_token", null: false
    t.datetime "password_reset_at"
    t.boolean "is_email_verified", default: false
    t.string "job_desire"
    t.string "job_experience"
    t.string "identifier"
    t.string "identifier_type"
    t.string "website"
    t.bigint "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_approved", default: false
    t.index ["email"], name: "index_volunteers_on_email", unique: true
    t.index ["password_reset_token"], name: "index_volunteers_on_password_reset_token", unique: true
    t.index ["phone_id"], name: "index_volunteers_on_phone_id"
    t.index ["token"], name: "index_volunteers_on_token", unique: true
  end

  add_foreign_key "patients", "phones"
  add_foreign_key "volunteers", "phones"
end
