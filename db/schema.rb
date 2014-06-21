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

ActiveRecord::Schema.define(version: 20140621033111) do

  create_table "raw_cashes", force: true do |t|
    t.integer  "no"
    t.integer  "page"
    t.integer  "row"
    t.date     "txn_dt"
    t.string   "txn_code"
    t.string   "user_nm"
    t.string   "identification"
    t.integer  "receive_money"
    t.integer  "pay_money"
    t.string   "cash_ind"
    t.string   "area"
    t.string   "correct_rate"
    t.string   "correct_rate_imp"
    t.string   "file"
    t.string   "account"
    t.string   "position"
    t.float    "term"
    t.datetime "created_at"
  end

end
