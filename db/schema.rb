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

ActiveRecord::Schema.define(version: 20160224190414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address",     null: false
    t.integer  "zipcode",     null: false
    t.string   "city",        null: false
    t.string   "phone",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
    t.integer  "country_id"
    t.string   "firstname",   null: false
    t.string   "lastname",    null: false
    t.string   "type",        null: false
    t.integer  "order_id"
  end

  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id", using: :btree

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "firstname",  null: false
    t.string   "lastname",   null: false
    t.text     "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "author_id"
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id", using: :btree
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",                                     null: false
    t.text     "description"
    t.decimal  "price",             precision: 9, scale: 2, null: false
    t.integer  "quantity_in_stock",                         null: false
    t.integer  "category_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "number",           limit: 8
    t.integer  "cvv"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.integer  "customer_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "order_id"
  end

  add_index "credit_cards", ["order_id"], name: "index_credit_cards_on_order_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "firstname",                           null: false
    t.string   "lastname",                            null: false
    t.string   "email",                  default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.string   "title",                              null: false
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.decimal  "price",      precision: 9, scale: 2, null: false
    t.integer  "quantity",                           null: false
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",    precision: 9, scale: 2,                         null: false
    t.datetime "completed_date",                                                 null: false
    t.string   "state",                                  default: "in progress", null: false
    t.integer  "customer_id"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "delivery_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.text     "review"
    t.integer  "rating"
    t.integer  "customer_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "addresses", "orders"
  add_foreign_key "credit_cards", "orders"
end
