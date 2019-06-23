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

ActiveRecord::Schema.define(version: 2019_06_23_173328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "manuscript_lines", force: :cascade do |t|
    t.text "transcribed_line"
    t.text "html_line"
    t.string "sel_id"
    t.string "witness_line_number"
    t.string "ms_line_number"
    t.text "notes"
    t.integer "witness_id"
    t.boolean "marginal_note", default: false
  end

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
    t.string "catalog_url"
    t.string "sc_number"
    t.text "notes"
    t.string "status"
    t.string "owned"
    t.float "price"
    t.boolean "major_ms"
    t.string "digital_edition_url"
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
    t.string "calendar_day"
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

  create_table "witnesses", force: :cascade do |t|
    t.integer "manuscript_id"
    t.integer "saints_legend_id"
    t.string "position"
    t.string "folios"
    t.text "description"
    t.text "notes"
    t.string "incipit"
    t.string "explicit"
    t.boolean "transcribed", default: false
  end

end
