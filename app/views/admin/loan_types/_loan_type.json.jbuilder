json.extract! loan_type, :id, :short_name, :description, :payment_frequency_days, :is_profit_balane, :number_of_payments, :profit_by_payment, :total_profit, :late_fee, :late_fee_profit, :created_at, :updated_at
json.url loan_type_url(loan_type, format: :json)
