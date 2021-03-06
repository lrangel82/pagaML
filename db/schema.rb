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

ActiveRecord::Schema.define(version: 2021_03_26_002232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "extra_fees", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.decimal "late_fee"
    t.decimal "late_fee_profit"
    t.decimal "old_balance"
    t.decimal "new_balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loan_id"], name: "index_extra_fees_on_loan_id"
  end

  create_table "loan_types", force: :cascade do |t|
    t.text "short_name"
    t.text "description"
    t.integer "payment_frequency_days"
    t.boolean "is_profit_balane"
    t.integer "number_of_payments"
    t.decimal "profit_by_payment"
    t.decimal "total_profit"
    t.decimal "late_fee"
    t.decimal "late_fee_profit"
    t.integer "days_added"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "counts"
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "moneylender_id", null: false
    t.bigint "status_id", null: false
    t.decimal "amount_borrowed"
    t.decimal "balance"
    t.date "loan_date"
    t.date "start_date"
    t.date "next_payment_date"
    t.decimal "next_amount_payment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "clabe", limit: 16
    t.integer "account_number"
    t.string "bank"
    t.integer "payment_frequency_days"
    t.boolean "is_profit_balane"
    t.integer "number_of_payments"
    t.decimal "profit_by_payment"
    t.text "description"
    t.date "end_date"
    t.index ["moneylender_id"], name: "index_loans_on_moneylender_id"
    t.index ["status_id"], name: "index_loans_on_status_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "moneylender_users", force: :cascade do |t|
    t.bigint "moneylender_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["moneylender_id"], name: "index_moneylender_users_on_moneylender_id"
    t.index ["user_id"], name: "index_moneylender_users_on_user_id"
  end

  create_table "moneylenders", force: :cascade do |t|
    t.text "alias"
    t.text "clabe"
    t.integer "account_number"
    t.text "bank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_moneylenders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.decimal "amount"
    t.date "payment_date"
    t.decimal "profit"
    t.decimal "payment_to_borrowed"
    t.bigint "status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.index ["loan_id"], name: "index_payments_on_loan_id"
    t.index ["parent_id"], name: "index_payments_on_parent_id"
    t.index ["status_id"], name: "index_payments_on_status_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: "", null: false
    t.text "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.text "name", default: "", null: false
    t.text "lastname", default: "", null: false
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text "current_sign_in_ip"
    t.text "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.text "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "extra_fees", "loans"
  add_foreign_key "loans", "moneylenders"
  add_foreign_key "loans", "statuses"
  add_foreign_key "loans", "users"
  add_foreign_key "moneylender_users", "moneylenders"
  add_foreign_key "moneylender_users", "users"
  add_foreign_key "moneylenders", "users"
  add_foreign_key "payments", "loans"
  add_foreign_key "payments", "payments", column: "parent_id"
  add_foreign_key "payments", "statuses"
end
