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

ActiveRecord::Schema.define(version: 2020_10_13_033247) do

  create_table "extra_fees", force: :cascade do |t|
    t.integer "loan_id", null: false
    t.decimal "late_fee"
    t.decimal "late_fee_profit"
    t.decimal "old_balance"
    t.decimal "new_balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loan_id"], name: "index_extra_fees_on_loan_id"
  end

  create_table "loan_types", force: :cascade do |t|
    t.string "short_name", limit: 50
    t.string "description", limit: 500
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
  end

  create_table "loans", force: :cascade do |t|
    t.integer "moneylender_id", null: false
    t.integer "status_id", null: false
    t.integer "loan_type_id", null: false
    t.decimal "amount_borrowed"
    t.decimal "balance"
    t.date "loan_date"
    t.date "start_date"
    t.date "next_payment_date"
    t.decimal "next_amount_payment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "clabe", limit: 16
    t.integer "account_number"
    t.string "bank"
    t.index ["loan_type_id"], name: "index_loans_on_loan_type_id"
    t.index ["moneylender_id"], name: "index_loans_on_moneylender_id"
    t.index ["status_id"], name: "index_loans_on_status_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "moneylenders", force: :cascade do |t|
    t.string "alias"
    t.string "clabe", limit: 16
    t.integer "account_number"
    t.string "bank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_moneylenders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "loan_id", null: false
    t.decimal "amount"
    t.date "payment_date"
    t.decimal "profit"
    t.decimal "payment_to_borrowed"
    t.integer "status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loan_id"], name: "index_payments_on_loan_id"
    t.index ["status_id"], name: "index_payments_on_status_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "name", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
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
  add_foreign_key "loans", "loan_types"
  add_foreign_key "loans", "moneylenders"
  add_foreign_key "loans", "statuses"
  add_foreign_key "loans", "users"
  add_foreign_key "moneylenders", "users"
  add_foreign_key "payments", "loans"
  add_foreign_key "payments", "statuses"
end
