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

ActiveRecord::Schema.define(version: 2021_05_04_122747) do

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.string "uid", null: false
    t.index ["mail"], name: "index_customers_on_mail", unique: true
    t.index ["tel"], name: "index_customers_on_tel", unique: true
    t.check_constraint "egexp_like(`mail`,_utf8mb4\\'^[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z]{2,4}$\\'", name: "only_mail_address"
    t.check_constraint "egexp_like(`tel`,_utf8mb4\\'^0[[:digit:]]{9,10}$\\'", name: "only_phone_number"
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
    t.integer "price"
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
    t.string "tel", null: false
    t.string "mail", null: false
    t.string "uid", null: false
    t.index ["rank_id"], name: "index_stylists_on_rank_id"
    t.check_constraint "egexp_like(`mail`,_utf8mb4\\'^[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z]{2,4}$\\'", name: "stylists_only_mail_address"
    t.check_constraint "egexp_like(`tel`,_utf8mb4\\'^0[[:digit:]]{9,10}$\\'", name: "stylists_only_phone_number"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "stylists"
  add_foreign_key "prices", "menus"
  add_foreign_key "prices", "ranks"
  add_foreign_key "stylists", "ranks"
end
