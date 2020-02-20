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

ActiveRecord::Schema.define(version: 2020_02_20_183928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_categories", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_bill_categories_on_bill_id"
    t.index ["category_id"], name: "index_bill_categories_on_category_id"
  end

  create_table "bill_users", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_bill_users_on_bill_id"
    t.index ["user_id"], name: "index_bill_users_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.string "code"
    t.string "title"
    t.string "description"
    t.date "introduced_date"
    t.string "summary_url"
    t.string "page_url"
    t.string "full_text_url"
    t.boolean "passed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_bills_on_session_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "uclassify_class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_users", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_category_users_on_category_id"
    t.index ["user_id"], name: "index_category_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.string "code"
    t.string "title"
    t.date "publication_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_events_on_bill_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "number"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "phone_number"
    t.string "postal_code"
    t.boolean "email_notification"
    t.boolean "sms_notification"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bill_categories", "bills"
  add_foreign_key "bill_categories", "categories"
  add_foreign_key "bill_users", "bills"
  add_foreign_key "bill_users", "users"
  add_foreign_key "bills", "sessions"
  add_foreign_key "category_users", "categories"
  add_foreign_key "category_users", "users"
  add_foreign_key "events", "bills"
end
