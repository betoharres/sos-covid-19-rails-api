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

ActiveRecord::Schema.define(version: 2020_04_04_230432) do

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
    t.index ["phone_id"], name: "index_patients_on_phone_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number", null: false
    t.string "verification_code"
    t.boolean "is_verified", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_phones_on_number", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.string "identifier_type"
    t.bigint "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phone_id"], name: "index_volunteers_on_phone_id"
  end

  add_foreign_key "patients", "phones"
  add_foreign_key "volunteers", "phones"
end
