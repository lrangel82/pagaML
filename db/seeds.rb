# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Payment.destroy_all
Loan.destroy_all
LoanType.destroy_all
Moneylender.destroy_all
User.destroy_all
Status.destroy_all

ActiveRecord::Base.connection.execute("SELECT setval('statuses_id_seq', (SELECT max(id) FROM statuses));")

Status.create(id: 1, name: "Open")
Status.create(id: 2, name: "Paid")
Status.create(id: 3, name: "Prepaid")
Status.create(id: 4, name: "Cancel")
Status.create(id: 5, name: "Close")
Status.create(id: 6, name: "Default")

ActiveRecord::Base.connection.execute("SELECT setval('statuses_id_seq', (SELECT max(id) FROM statuses));")

#User.create(id: 1, email: "r_hermon@hotmail.com", created_at: "2020-10-10 12:42:08", updated_at: "2020-10-10 12:42:08", provider: "facebook", uid: "10158842071261774")
#<User id: 1, email: "luisrangel@gmail.com", created_at: "2020-10-13 05:01:35", updated_at: "2020-10-13 05:01:35", provider: nil, uid: nil>

User.new(id: 1, email: "luisrangel@gmail.com", password: "mevale14", admin: true, name: "Luis", lastname:"Rangel").save!(:validate => false)
User.new(id: 2, email: "orozcomartina8@gmail.com", password: "mevale14", admin: true, name: "Martina", lastname:"Orozco").save!(:validate => false)

ActiveRecord::Base.connection.execute("SELECT setval('users_id_seq', (SELECT max(id) FROM users));")
#User.new(id: 3, email: "foo1@foo.com", password: "foooo14", admin: false, name: "Tania", lastname:"").save!(:validate => false)
#User.new(id: 4, email: "foo2@foo.com", password: "foooo14", admin: false, name: "Angelica", lastname:"Karen amiga").save!(:validate => false)
#User.new(id: 5, email: "foo3@foo.com", password: "foooo14", admin: false, name: "Dr. Marisol", lastname:"").save!(:validate => false)
#User.new(id: 6, email: "foo4@foo.com", password: "foooo14", admin: false, name: "Elizabeth", lastname:"Lopez").save!(:validate => false)
#User.new(id: 7, email: "foo5@foo.com", password: "foooo14", admin: false, name: "Yuri", lastname:"").save!(:validate => false)

#[["email", "luisrangel@gmail.com"], ["encrypted_password", "$2a$12$UkYFBLzdmpoHYAlpDxtdl.VdtYJA/8PdNjoiTl3KlPGtutAUJO6q6"], ["created_at", "2020-10-13 05:01:35.253233"], ["updated_at", "2020-10-13 05:01:35.253233"]]


Moneylender.create(alias:"LuisBR", clabe:"123456789012345", account_number: 45, bank: "BANREGIO", user_id: 1)
Moneylender.create(alias:"LuisBX", clabe:"123456789012345", account_number: 45, bank: "BANAMEX", user_id: 1)
Moneylender.create(alias:"Martina", clabe:"123456789012345", account_number: 45, bank: "BANCOPEL", user_id: 2)

ActiveRecord::Base.connection.execute("SELECT setval('moneylenders_id_seq', (SELECT max(id) FROM moneylenders));")



LoanType.create(id: 1, short_name: "Mensual 10%", description: "Pago mensual sin limite de pagos 10%", payment_frequency_days: 30, is_profit_balane: true, number_of_payments: nil, profit_by_payment: 0.1e2, total_profit: nil, late_fee: 0.3e3, late_fee_profit: 0.5e1)

LoanType.create(id: 2, short_name: "Mensual 6%", description: "Pago mensual sin limite de pagos 6%", payment_frequency_days: 30, is_profit_balane: true, number_of_payments: nil, profit_by_payment: 0.6e1, total_profit: nil, late_fee: 0.3e3, late_fee_profit: 0.5e1)

LoanType.create(id: 3, short_name: "12 Semanas 30%", description: "Pago semanal con 30% de interes total 10 por mes", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 12, profit_by_payment: 0.25e1, total_profit: 0.3e2, late_fee: 0.1e3, late_fee_profit: 0.0)

LoanType.create(id: 4, short_name: "12 Semanas 18%", description: "Pago semanal con 18% de interes total 6% por mes", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 12, profit_by_payment: nil, total_profit: 0.18e2, late_fee: 0.1e3, late_fee_profit: 0.0)

LoanType.create(id: 5, short_name: "Mensual 15%", description: "Pago mensual sin limite de pagos 15%", payment_frequency_days: 30, is_profit_balane: true, number_of_payments: nil, profit_by_payment: 0.15e2, total_profit: nil, late_fee: 0.3e3, late_fee_profit: 0.5e1)

LoanType.create(id: 6, short_name: "1 Semanas 5%", description: "Pago 1 semana con 5% de interes total", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 1, profit_by_payment: nil, total_profit: 0.05e2, late_fee: 0.01e2, late_fee_profit: 0.0)

LoanType.create(id: 7, short_name: "4 Semanas 10%", description: "Pago 4 semanas con 10% de interes total", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 4, profit_by_payment: nil, total_profit: 0.10e2, late_fee: 0.10e2, late_fee_profit: 0.0)

LoanType.create(id: 8, short_name: "8 Semanas 20%", description: "Pago 8 semanas con 20% de interes total", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 8, profit_by_payment: nil, total_profit: 0.20e2, late_fee: 0.10e2, late_fee_profit: 0.0)

LoanType.create(id: 9, short_name: "Eterno", description: "prestamo al olvido 0 ganancia", payment_frequency_days: 365, is_profit_balane: false, number_of_payments: 1, profit_by_payment: nil, total_profit: 0.00e2, late_fee: 0.0e2, late_fee_profit: 0.0)

LoanType.create(id: 10, short_name: "16 Semanas 40%", description: "Pago semanal con 40% de interes total 10 por mes", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 16, profit_by_payment: 0.25e1, total_profit: 0.4e2, late_fee: 0.1e3, late_fee_profit: 0.0)

ActiveRecord::Base.connection.execute("SELECT setval('loan_types_id_seq', (SELECT max(id) FROM loan_types));")

#PRESTAMOS
# Loan.create(id: 29, moneylender_id: 1, status_id: 1, loan_type_id: 3, amount_borrowed: 2500, balance: 811, loan_date: "2020-08-13", start_date: "2020-08-13", next_payment_date: "2020-10-22", next_amount_payment: 0, user_id: 3)

# Loan.create(id: 32, moneylender_id: 1, status_id: 1, loan_type_id: 3, amount_borrowed: 5000, balance: 2706, loan_date: "2020-08-22", start_date: "2020-08-22", next_payment_date: "2020-10-17", next_amount_payment: 0, user_id: 4)

# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-08-22", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-08-30", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-09-08", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-09-14", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-09-20", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-09-27", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-10-05", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-10-11", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)
# Payment.create(loan_id: 29, amount: 271, payment_date: "2020-10-18", profit: 62.5, payment_to_borrowed: 208.5, status_id: 2)


# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-08-31", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-09-08", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-09-14", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-09-20", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-09-28", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-10-06", profit: 125, payment_to_borrowed: 417, status_id: 2)
# Payment.create(loan_id: 32, amount: 542, payment_date: "2020-10-12", profit: 125, payment_to_borrowed: 417, status_id: 2)

# #Payment.create(id: integer, loan_id: integer, amount: decimal, payment_date: date, profit: decimal, payment_to_borrowed: decimal, status_id: integer, created_at: datetime, updated_at: datetime)