# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Status.create(name: "Open")
Status.create(name: "Paid")
Status.create(name: "Prepaid")
Status.create(name: "Cancel")
Status.create(name: "Close")
Status.create(name: "Defaulter")

#User.create(id: 1, email: "r_hermon@hotmail.com", created_at: "2020-10-10 12:42:08", updated_at: "2020-10-10 12:42:08", provider: "facebook", uid: "10158842071261774")
#[["email", "luisrangel@gmail.com"], ["encrypted_password", "$2a$12$UkYFBLzdmpoHYAlpDxtdl.VdtYJA/8PdNjoiTl3KlPGtutAUJO6q6"], ["created_at", "2020-10-13 05:01:35.253233"], ["updated_at", "2020-10-13 05:01:35.253233"]]

Moneylender.create(alias:"L", clabe:"123456789012345", account_number: 7436278982, bank: "PATITO", user_id: 1)

LoanType.create(id: 1, short_name: "Mensual 10%", description: "Pago mensual sin limite de pagos 10%", payment_frequency_days: 30, is_profit_balane: true, number_of_payments: nil, profit_by_payment: 0.1e2, total_profit: nil, late_fee: 0.3e3, late_fee_profit: 0.5e1)

LoanType.create(id: 2, short_name: "12 Semanas 30%", description: "Pago semanal con 30% de interes total 10 por mes", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 12, profit_by_payment: 0.25e1, total_profit: nil, late_fee: 0.1e3, late_fee_profit: 0.0)


Loan.create(id: 1, moneylender_id: 1, status_id: 1, loan_type_id: 1, amount_borrowed: 0.2e4, balance: 0.2e4, loan_date: "2020-10-09", start_date: "2020-10-18", next_payment_date: "2020-11-09", next_amount_payment: 0.2e3, created_at: "2020-10-09 05:02:54", updated_at: "2020-10-09 05:02:54", user_id: 1)



#Payment.create(id: integer, loan_id: integer, amount: decimal, payment_date: date, profit: decimal, payment_to_borrowed: decimal, status_id: integer, created_at: datetime, updated_at: datetime)