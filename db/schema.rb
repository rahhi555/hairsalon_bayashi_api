# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_20_125915) do

  create_table "appointments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.datetime "appointment_on"
    t.text "remark"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "stylist_id", null: false
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["stylist_id"], name: "index_appointments_on_stylist_id"
  end

  create_table "appointments_menus", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "appointment_id"
    t.bigint "menu_id"
    t.index ["appointment_id"], name: "index_appointments_menus_on_appointment_id"
    t.index ["menu_id"], name: "index_appointments_menus_on_menu_id"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "tel", null: false
    t.string "mail", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mail"], name: "index_customers_on_mail", unique: true
    t.index ["tel"], name: "index_customers_on_tel", unique: true
    # t.check_constraint "egexp_like(`mail`,_latin1\\'^[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z]{2,4}$\\'", name: "only_mail_address"
    # t.check_constraint "egexp_like(`tel`,_utf8mb4\\'^0[[:digit:]]{9,10}$\\'", name: "only_phone_number"
  end

  create_table "menus", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.time "time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_menus_on_code", unique: true
    t.index ["name"], name: "index_menus_on_name", unique: true
  end

  create_table "prices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "rank_id", null: false
    t.bigint "menu_id", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_prices_on_menu_id"
    t.index ["rank_id"], name: "index_prices_on_rank_id"
  end

  create_table "ranks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_ranks_on_name", unique: true
  end

  create_table "stylists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "rank_id"
    t.string "name", null: false
    t.boolean "is_male", null: false
    t.string "nickname"
    t.date "hire_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rank_id"], name: "index_stylists_on_rank_id"
  end

  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "stylists"
  add_foreign_key "prices", "menus"
  add_foreign_key "prices", "ranks"
  add_foreign_key "stylists", "ranks"
end
