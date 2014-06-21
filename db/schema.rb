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

ActiveRecord::Schema.define(version: 20140621054001) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.integer  "politician_id"
    t.datetime "created_at"
  end

  add_index "accounts", ["politician_id"], name: "index_accounts_on_politician_id", using: :btree

  create_table "codes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "codes", ["name"], name: "index_codes_on_name", using: :btree

  create_table "donators", force: true do |t|
    t.string   "name"
    t.string   "identification"
    t.datetime "created_at"
  end

  add_index "donators", ["identification"], name: "index_donators_on_identification", using: :btree
  add_index "donators", ["name"], name: "index_donators_on_name", using: :btree

  create_table "politicians", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "politicians", ["name"], name: "index_politicians_on_name", using: :btree

  create_table "raw_politicians", force: true do |t|
    t.string   "account_name"
    t.string   "politician_name"
    t.string   "bank_name"
    t.string   "bank_account"
    t.string   "bank_address"
    t.string   "date1"
    t.string   "date2"
    t.datetime "created_at"
  end

  add_index "raw_politicians", ["account_name"], name: "index_raw_politicians_on_account_name", using: :btree

  create_table "raw_transactions", force: true do |t|
    t.string   "account_name"
    t.date     "date"
    t.string   "code"
    t.string   "donator"
    t.string   "identification"
    t.integer  "income"
    t.integer  "payout"
    t.string   "is_money"
    t.string   "address"
    t.integer  "page"
    t.integer  "row"
    t.datetime "created_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "transaction_type"
    t.date     "date"
    t.integer  "account_id"
    t.integer  "politician_id"
    t.integer  "donator_id"
    t.integer  "code_id"
    t.integer  "amount"
    t.boolean  "is_money"
    t.string   "address"
    t.integer  "page"
    t.integer  "row"
    t.datetime "created_at"
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree
  add_index "transactions", ["code_id"], name: "index_transactions_on_code_id", using: :btree
  add_index "transactions", ["date"], name: "index_transactions_on_date", using: :btree
  add_index "transactions", ["donator_id"], name: "index_transactions_on_donator_id", using: :btree
  add_index "transactions", ["politician_id"], name: "index_transactions_on_politician_id", using: :btree

end
