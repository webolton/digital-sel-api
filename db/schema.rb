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

ActiveRecord::Schema.define(version: 2018_12_26_220223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "manuscripts", force: :cascade do |t|
    t.string "shelfmark"
    t.string "siglum"
    t.string "country"
    t.string "city"
    t.string "repository"
    t.date "date"
    t.text "description"
    t.text "dialect"
    t.text "scribal_description"
    t.text "provenance"
    t.string "url"
    t.string "sc_number"
    t.text "notes"
    t.string "status"
    t.string "owned"
    t.float "price"
    t.boolean "major_ms"
  end

  create_table "saints_legends", force: :cascade do |t|
    t.string "siglum"
    t.string "title"
    t.date "date"
    t.text "summary"
    t.string "position"
    t.string "incipit"
    t.string "imev_number"
    t.string "nimev_number"
    t.string "dimev_number"
    t.text "notes"
    t.string "versification"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
